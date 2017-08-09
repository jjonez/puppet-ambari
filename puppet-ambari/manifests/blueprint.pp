class ambari::blueprint(

  $ambari_server             = $::ambari::params::ambari_server,
  $ambari_server_port        = $::ambari::params::ambari_server_port,
  $ambari_comm_port          = $::ambari::params::ambari_comm_port,
  $ambari_comm_secure_port   = $::ambari::params::ambari_comm_secure_port,
  $hdp_stack_version         = $::ambari::params::hdp_stack_version,
  $num_datanodes 	           = $::ambari::params::num_datanodes,
  $cluster_name  	           = $::ambari::params::cluster_name,
  $cluster_config	           = $::ambari::params::cluster_config,
  $hostmap_config     	     = $::ambari::params::hostmap_config,
  $master_nodes              = $::ambari::params::master_nodes,
  $worker_nodes              = $::ambari::params::worker_nodes,
  $hdp_hdfs_nameservice_id   = $::ambari::params::hdp_hdfs_nameservice_id

)inherits ::ambari::params {

  contain ambari::blueprint::cluster
  contain ambari::blueprint::hostmap

  Class[::ambari::blueprint::cluster] ->
  Class[::ambari::blueprint::hostmap]

}

