# == Class: ambari::firewall
class ambari::os::firewall inherits ambari {

 # Install firewalld
 package { firewalld:
   ensure => 'installed',
   require => Package['yum']
 }

 # Configure Firewall Ports
 #TODO: For now we just disable firewall. Need to configure Firewall ports in the future
 service { 'firewalld':
   ensure => 'stopped',
   enable => false
 }

}
