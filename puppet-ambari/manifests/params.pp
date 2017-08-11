class ambari::params {
 
  # Ambari Server Params
  $ambari_server    = 'ip-172-31-45-96.us-east-2.compute.internal'
  $master_nodes     = [
        'ip-172-31-45-96.us-east-2.compute.internal',
        'ip-172-31-39-26.us-east-2.compute.internal',
        'ip-172-31-38-9.us-east-2.compute.internal',
        ]
  $worker_nodes     = [
        'ip-172-31-36-28.us-east-2.compute.internal',
        'ip-172-31-43-59.us-east-2.compute.internal',
        'ip-172-31-36-69.us-east-2.compute.internal']
  $elastic_nodes    = 'ip-172-31-46-67.us-east-2.compute.internal'

  # Blueprint specific
  $blueprint_configs = {
    "hdfs_site" => {
      "dfs.datanode.data.dir"       =>  "/hadoop/hdfs/data"
    },
    "yarn_site" => {
      "yarn.nodemanager.local-dirs" => "/hadoop/yarn/local"
      "yarn.nodemanager.log-dirs"   => "/hadoop/yarn/log"
    },
    "zoo_cfg" => {
      "dataDir" => "/hadoop/zookeeper"
    }
  }


  $ambari_server_port 		  = 8080
  $ambari_comm_port 		    = 8440
  $ambari_comm_secure_port 	= 8441  # for future use

  $hdp_stack_version            = '2.6'

  $ambari_user                  = 'ambari'  
  $hadoop_group                 = 'hadoop'  # Ignored if $ambari_user is 'root'

  # Ambari/HDP Repo URL's
  $ambari_repo_url           	= 'http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.5.1.0' 
  $hdp_repo_url              	= 'http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.6.1.0'
  $hdp_utils_repo_url        	= 'http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.21/repos/centos7'
  # Internal yum repo URL. Required if installing jetty9 even if you are on the internet
  $internal_repo_url        	= 'http://192.168.56.104/rpms/centos7'

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
