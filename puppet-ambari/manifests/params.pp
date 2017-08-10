class ambari::params {
 
  # Ambari Server Params
  $ambari_server 		= 'master1.puppet.local'

  $ambari_server_port 		= 8080
  $ambari_comm_port 		= 8440
  $ambari_comm_secure_port 	= 8441  # for future use
  $num_ambari_agents            = 1     # to verify that all have registered with the server

  $hdp_stack_version            = '2.6'

  $ambari_user                  = 'ambari'  
  $hadoop_group                 = 'hadoop'  # Ignored if $ambari_user is 'root'

  # Ambari/HDP Repo URL's
  $ambari_repo_url           	= 'http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.5.1.0' 
  $hdp_repo_url              	= 'http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.6.1.0'
  $hdp_utils_repo_url        	= 'http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.21/repos/centos7'

  # Java Prams
  $java_version                 = 'java-1.8.0-openjdk-devel'
  $java_home 			= '/usr/lib/jvm/java-1.8.0-openjdk'

  # Blueprint params 
  
  $cluster_name  		= 'hdp1'  # recommended to use all lowercase, only letters and numbers
  
  $cluster_config 	= 'cluster_full_stack.json.erb'
  $hostmap_config 	= 'hostmap_full_stack.json.erb'

  $master_nodes = ['master1.puppet.local', 'master2.puppet.local', 'master3.puppet.local']
  $worker_nodes = ['worker1.puppet.local', 'worker2.puppet.local']

  $num_datanodes 		= $master_nodes.size + $worker_nodes.size

  #if $num_datanodes = 1
  #  $cluster_config = 'cluster_single_node.json.erb'
  #  $hostmap_config = 'hostmap_single_stack.json.erb'
  #end

  $hdp_hdfs_nameservice_id  = 'mycluster'

}
