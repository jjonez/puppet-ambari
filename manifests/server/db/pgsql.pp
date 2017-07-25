class ambari::server::db::pgsql {

 package { postgresql:
   ensure => 'installed',
   require => Package['ambari-server']
 }

 service { 'postgresql':
    ensure => 'running',
    require => Package['postgresql']
 }

 # Configure Postgres for HDP
 file {
  'configure_postgres_hdp_script' :
  ensure => 'file',
  source => 'puppet:///modules/ambari/configure_postgres.sh',
  path => '/tmp/configure_postgres.sh',
  owner => 'root',
  group => 'root',
  mode  => '0744',
  require => Class['::ambari::server::service'],
#require => Exec['run_ambari_server_setup'],
  notify => Exec['run_configure_postgres_hdp_script'],
 }

 exec {
  'run_configure_postgres_hdp_script':
  command => "/bin/bash /tmp/configure_postgres.sh",
  refreshonly => true
 }

}
