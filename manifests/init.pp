# Class: ambari
class ambari {
    include ambari::os::packages
    include ambari::os::jdk
    include ambari::os::ntp
    include ambari::os::thp
    include ambari::os::firewall
}
