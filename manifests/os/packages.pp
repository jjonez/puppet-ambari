# == Class: ambari::packages
class ambari::os::packages inherits ambari {

 # Install Pre-required Software
 $hdp_prereq_software = [ 'chkconfig', 'curl', 'rpm', 'openssh-clients', 'tar', 'unzip', 'wget', 'yum', 'expect' ]

 package { $hdp_prereq_software: 
   ensure => 'installed' 
 }

}
