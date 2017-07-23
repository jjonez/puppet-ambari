# == Class: ambari::packages
class ambari::os::packages inherits ambari {

 # Install Pre-required Software
 $hdp_prereq_software = [ 'chkconfig', 'curl', 'rpm', 'openssh-clients', 'tar', 'unzip', 'wget', 'yum' ]

 package { $hdp_prereq_software: 
   ensure => 'installed' 
 }

}
