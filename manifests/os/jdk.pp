class ambari::os::jdk() {

 $java_version = $::ambari::os::java_version

 package { "${java_version}":
   ensure => 'installed',
   require => Package['yum']
 }

}
