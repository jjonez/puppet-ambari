class ambari::blueprint(

  $ambari_server             = $::ambari::params::ambari_server,
  $ambari_server_port        = $::ambari::params::ambari_server_port,
  $ambari_comm_port          = $::ambari::params::ambari_comm_port,
  $ambari_comm_secure_port   = $::ambari::params::ambari_comm_secure_port,
  $num_ambari_agents         = $::ambari::params::num_ambari_agents,
  $hdp_stack_version         = $::ambari::params::hdp_stack_version,
  $num_datanodes 	     = $::ambari::params::num_datanodes,
  $cluster_name  	     = $::ambari::params::cluster_name,
  $cluster_config	     = $::ambari::params::cluster_config,
  $hostmap_config     	     = $::ambari::params::hostmap_config

)inherits ::ambari::params {

  contain ambari::blueprint::repos
  contain ambari::blueprint::wait_for_agents
  contain ambari::blueprint::cluster
  contain ambari::blueprint::hostmap

  Class[::ambari::blueprint::repos] ->
  Class[::ambari::blueprint::wait_for_agents] ->
  Class[::ambari::blueprint::cluster] ->
  Class[::ambari::blueprint::hostmap]

}

