class ambari::os::firewall() {

 package { firewalld:
   ensure => 'installed',
   require => Package['yum']
 } ->
 service { 'firewalld':
   ensure => 'stopped',
   enable => false
 }

}
