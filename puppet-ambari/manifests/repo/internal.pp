class ambari::repo::internal() {

 $internal_repo_url = $::ambari::repo::internal_repo_url

 # Note - HDP and HDP-UTILS repos are configured via bleuprints
 

  if $internal_repo_url != undef and $internal_repo_url != "" {
    yumrepo { 'internal':
     descr    => 'internal repo',
     enabled  => 1,
     baseurl  => "${internal_repo_url}",
     gpgcheck => 0,
   } 
 }
}
