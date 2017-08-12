class ambari::blueprint::cluster() {

 $ambari_server           = $::ambari::blueprint::ambari_server
 $ambari_server_port      = $::ambari::blueprint::ambari_server_port
 $hdp_stack_version       = $::ambari::blueprint::hdp_stack_version
 $num_datanodes           = $::ambari::blueprint::num_datanodes
 $cluster_name            = $::ambari::blueprint::cluster_name
 $cluster_config          = $::ambari::blueprint::cluster_config
 $hdp_hdfs_nameservice_id = $::ambari::blueprint::hdp_hdfs_nameservice_id
 $worker_nodes            = $::ambari::blueprint::worker_nodes
 $elastic_nodes           = $::ambari::blueprint::elastic_nodes
 $blueprint_configs       = $::ambari::blueprint::blueprint_configs

 $url = "http://${ambari_server}:${ambari_server_port}/api/v1/blueprints/${cluster_name}" 

 file {
   'cluster_config_file':
   ensure => 'file',
   content => template("ambari/blueprint/$cluster_config"),
   path => '/var/lib/puppet-ambari/cluster_config.json',
   owner => 'root',
   group => 'root',
   mode  => '0700',
   notify => Exec['run_cluster_blueprint'],
 } -> 
 exec {
  'run_cluster_blueprint':
  command => "/bin/env curl -f -H 'X-Requested-By: ambari' -X POST -u admin:admin $url -d @/var/lib/puppet-ambari/cluster_config.json",
  refreshonly => true
 }

}
