class ambari::repo(

  $ambari_repo_url           = $::ambari::params::ambari_repo_url,

)inherits ::ambari::params {

  contain ambari::repo::ambari

#  Class[ambari::repo::ambari]

}


