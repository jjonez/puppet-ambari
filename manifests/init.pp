# Class: ambari
class ambari inherits ::ambari::params {
   include ambari::repo::ambari
   include ambari::repo::hdp
   include ambari::os::packages
   include ambari::os::jdk
   include ambari::os::ntp
   include ambari::os::thp
   include ambari::os::firewall
}

