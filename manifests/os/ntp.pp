# == Class: ambari::ntp
class ambari::os::ntp inherits ambari {

 # Install NTP
 package { ntp:
   ensure => 'installed',
   require => Package['yum']
 }

 # Configure NTP
 #TODO: For now we just start it. Need to update to create local NTP server since most likley no intenet access
 service { 'ntpd':
    ensure => 'running'
 }
}
