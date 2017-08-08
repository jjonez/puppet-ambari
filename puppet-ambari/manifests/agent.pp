class ambari::agent(

  $ambari_server           = $::ambari::params::ambari_server,
  $ambari_server_port      = $::ambari::params::ambari_server_port,
  $ambari_comm_port        = $::ambari::params::ambari_comm_port,
  $ambari_comm_secure_port = $::ambari::params::ambari_comm_secure_port

)inherits ::ambari::params {

  contain ::ambari::agent::install
  contain ::ambari::agent::config
  contain ::ambari::agent::service

  Class[::ambari::agent::install] ->
  Class[::ambari::agent::config] ->
  Class[::ambari::agent::service]

}

