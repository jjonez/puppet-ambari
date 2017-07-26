class ambari::repo::ambari() {

 $ambari_repo_url = $::ambari::repo::ambari_repo_url

 yumrepo { 'ambari':
   descr    => 'ambari Version - ambari-2.5.1.0',
   enabled  => 0,
   baseurl  => "${ambari_repo_url}",
   gpgcheck => 0,
 }

}
