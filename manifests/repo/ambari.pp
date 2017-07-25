# == Class: ambari::repo::ambari
class ambari::repo::ambari {
 # Configure all repos required for Ambari

 yumrepo { 'ambari':
   descr    => 'ambari Version - ambari-2.5.1.0',
   enabled  => 0,
   baseurl  => 'http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.5.1.0',
   gpgcheck => 0,
 }
}
