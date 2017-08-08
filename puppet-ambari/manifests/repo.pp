class ambari::repo(

  $ambari_repo_url           = $::ambari::params::ambari_repo_url,
  $hdp_repo_url              = $::ambari::params::hdp_repo_url,
  $hdp_utils_repo_url        = $::ambari::params::hdp_utils_repo_url

)inherits ::ambari::params {

  contain ambari::repo::ambari
  contain ambari::repo::hdp

  Class[ambari::repo::ambari] ->
  Class[ambari::repo::hdp]

}


