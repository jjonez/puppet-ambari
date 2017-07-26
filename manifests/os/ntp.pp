class ambari::os::ntp() {

 package { ntp:
   ensure => 'installed',
   require => Package['yum']
 } -> 
 service { 'ntpd':
   ensure => 'running',
   enable => 'true'
 }

}
