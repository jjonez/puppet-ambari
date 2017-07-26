# == Class: ambari::repo::hdp
class ambari::repo::hdp {
 # Configure all repos required for HDP
 yumrepo { 'hdp':
   descr    => 'HDP Version - HDP-2.6.1.0',
   enabled  => 1,
   baseurl  => 'http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.6.1.0',
   gpgcheck => 0,
 }

 # Configure HDP Utils repo
 yumrepo { 'hdp-utils':
   descr    => 'HDP-UTILS Version - HDP-UTILS-1.1.0.21',
   enabled  => 1,
   baseurl  => 'http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.21/repos/centos7',
   gpgcheck => 0,
 }
}
