class ambari::params {
 
  # Ambari Server Params
  $ambari_server    = hiera('ambari_server')
  $master_nodes     = hiera_array('master_nodes')
  $worker_nodes     = hiera_array('worker_nodes')
  $elastic_nodes    = hiera('elastic_nodes')

  # Blueprint specific
  $blueprint_configs = {
    "hdfs_site" => {
      "dfs.datanode.data.dir"       =>  "/hadoop/hdfs/data",
    },
    "yarn_site" => {
      "yarn.nodemanager.local-dirs" => "/hadoop/yarn/local",
      "yarn.nodemanager.log-dirs"   => "/hadoop/yarn/log",
    },
    "zoo_cfg" => {
      "dataDir" => "/hadoop/zookeeper",
    }
  }


  $ambari_server_port 		  = 8080
  $ambari_comm_port 		    = 8440
  $ambari_comm_secure_port 	= 8441  # for future use

  $hdp_stack_version            = '2.6'

  $ambari_user                  = 'ambari'  
  $hadoop_group                 = 'hadoop'  # Ignored if $ambari_user is 'root'

  # Ambari/HDP Repo URL's
  $ambari_repo_url           	= hiera('ambari_repo_url')
  $hdp_repo_url              	= hiera('hdp_repo_url')
  $hdp_utils_repo_url        	= hiera('hdp_utils_repo_url')
  # Internal yum repo URL. Required if installing jetty9 even if you are on the internet
  $internal_repo_url        	= hiera('internal_repo_url')

  # Java Prams
  $java_version                 = 'java-1.8.0-openjdk-devel'
  $java_home 			= '/usr/lib/jvm/java-1.8.0-openjdk'

  # Blueprint params 

  $cluster_name  		= 'hdp1'  # recommended to use all lowercase, only letters and numbers

  $cluster_config 	= 'cluster_full_stack.json.erb'
  $hostmap_config 	= 'hostmap_full_stack.json.erb'

  $num_datanodes 		= $master_nodes.size + $worker_nodes.size

  #if $num_datanodes = 1
  #  $cluster_config = 'cluster_single_node.json.erb'
  #  $hostmap_config = 'hostmap_single_stack.json.erb'
  #end

  $hdp_hdfs_nameservice_id  = 'mycluster'

}
