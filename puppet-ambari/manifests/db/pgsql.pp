class ambari::db::pgsql() {

 package { postgresql:
   ensure => 'installed',
   require => Package['ambari-server']
 } ->
 service { 'postgresql':
    ensure => 'running',
 } ->
 file {
   'configure_postgres_hdp_script' :
   ensure => 'file',
   source => 'puppet:///modules/ambari/db/configure_postgres.sh',
   path => '/var/lib/puppet-ambari/configure_postgres.sh',
   owner => 'root',
   group => 'root',
   mode  => '0744',
   require => Class['::ambari::server::config'],
   notify => Exec['run_configure_postgres_hdp_script'],
 } ->
 exec {
  'run_configure_postgres_hdp_script':
  command => "/bin/bash /var/lib/puppet-ambari/configure_postgres.sh",
  refreshonly => true
 }

}
