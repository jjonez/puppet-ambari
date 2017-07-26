class ambari::blueprint(

  $ambari_sever_hostname     = $::ambari::params::ambari_sever_hostname,
  $ambari_server_port        = $::ambari::params::ambari_server_port,
  $ambari_server_secure_port = $::ambari::params::ambari_server_secure_port,
  $num_datanodes 	     = $::ambari::params::num_datanodes,
  $cluster_name  	     = $::ambari::params::cluster_name,
  $cluster_config	     = $::ambari::params::cluster_config,
  $hostmap_config     	     = $::ambari::params::hostmap_config

)inherits ::ambari::params {

  contain ambari::blueprint::cluster
  contain ambari::blueprint::hostmap

  Class[::ambari::blueprint::cluster] ->
  Class[::ambari::blueprint::hostmap]

}

