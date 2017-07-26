class ambari::os::packages() {

 # Install Pre-required Software
 $hdp_prereq_software = [ 'chkconfig', 'curl', 'rpm', 'openssh-clients', 'tar', 'unzip', 'wget', 'yum', 'expect' ]

 package { $hdp_prereq_software: 
   ensure => 'installed' 
 }

}
