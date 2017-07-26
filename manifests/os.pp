class ambari::os(

  $java_version              = $::ambari::params::java_version

)inherits ::ambari::params {

  contain ambari::os::packages
  contain ambari::os::firewall
  contain ambari::os::jdk
  contain ambari::os::ntp
  contain ambari::os::thp

  Class[::ambari::os::packages] ->
  Class[::ambari::os::jdk] ->
  Class[::ambari::os::firewall] ->
  Class[::ambari::os::ntp] ->
  Class[::ambari::os::thp]

}


