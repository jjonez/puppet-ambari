class ambari::params {
  $amb_sever_hostname = 'puppet.local'
  $java_home = '/usr/lib/jvm/java-openjdk'

  # Blueprint params 
  $num_datanodes = 1 
  $cluster_name  = 'hdp1'  # recommended to use all lowercase, only letters and numbers
  $cluster_config = 'cluster_1_master.json.erb'
  $hostmap_config = 'hostmap.json.erb'

}
