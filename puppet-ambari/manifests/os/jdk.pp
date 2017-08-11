class ambari::os::jdk() {

 $java_version = $::ambari::params::java_version

 package { "${java_version}":
   ensure => 'installed'
 }

}
