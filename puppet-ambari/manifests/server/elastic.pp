class ambari::server::elastic() {

 file { 'copy_elastic_mpack':
   ensure => 'file',
   source => 'puppet:///modules/ambari/elastic/elastic-mpack-0.0.0.1.tar.gz',
   path => '/var/lib/puppet-ambari/elastic-mpack-0.0.0.1.tar.gz',
   owner => 'root',
   group => 'root',
   mode  => '0744',
   notify => Exec['register_with_ambari'],
 } ->
 exec { 'register_with_ambari':
   command => "/sbin/ambari-server install-mpack --mpack=/var/lib/puppet-ambari/elastic-mpack-0.0.0.1.tar.gz --force",
   refreshonly => true,
   notify => Exec['restart_ambari'],
 } ->
 exec { 'restart_ambari':
   command => "/sbin/ambari-server restart",
   refreshonly => true,
 }

}
