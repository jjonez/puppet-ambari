class ambari::server(

  $java_home		     = $::ambari::params::java_home

)inherits ::ambari::params {


  contain ambari::server::install
  contain ambari::server::config
  contain ambari::server::service
  contain ambari::server::ambari_user

  Class[::ambari::server::install] ->
  Class[::ambari::server::config]  ->
  Class[::ambari::server::ambari_user] ->
  Class[::ambari::server::service] 

}

