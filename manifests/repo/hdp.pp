class ambari::repo::hdp() {

 $hdp_repo_url = $::ambari::repo::hdp_repo_url
 $hdp_utils_repo_url = $::ambari::repo::hdp_utils_repo_url
 
 yumrepo { 'hdp':
   descr    => 'HDP Version - HDP-2.6.1.0',
   enabled  => 0,
   baseurl  => "${hdp_repo_url}",
   gpgcheck => 0,
 }->
 yumrepo { 'hdp-utils':
   descr    => 'HDP-UTILS Version - HDP-UTILS-1.1.0.21',
   enabled  => 0,
   baseurl  => "${hdp_utils_repo_url}",
   gpgcheck => 0,
 }

}
