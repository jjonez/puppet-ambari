class ambari::server(

  $java_home		     = $::ambari::params::java_home

)inherits ::ambari::params {


  contain ambari::server::install
  contain ambari::server::ambari_user
  contain ambari::server::config
  contain ambari::server::service
  contain ambari::server::elastic

  Class[::ambari::server::install] ->
  Class[::ambari::server::ambari_user] ->
  Class[::ambari::server::config]  ->
  Class[::ambari::server::service] -> 
  Class[::ambari::server::elastic]

}

