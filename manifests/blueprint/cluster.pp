class ambari::blueprint::cluster() {

 $ambari_sever_hostname = $::ambari::blueprint::ambari_sever_hostname
 $ambari_server_port = $::ambari::blueprint::ambari_server_port
 $num_datanodes = $::ambari::blueprint::num_datanodes
 $cluster_name  = $::ambari::blueprint::cluster_name
 $cluster_config= $::ambari::blueprint::cluster_config

 $url = "http://${ambari_sever_hostname}:${ambari_server_port}/api/v1/blueprints/${cluster_name}" 

 file {
   'cluster_config_file':
   ensure => 'file',
   content => template("ambari/blueprint/$cluster_config"),
   path => '/tmp/cluster_config.json',
   owner => 'root',
   group => 'root',
   mode  => '0700',
   notify => Exec['run_cluster_blueprint'],
 } -> 
 exec {
  'run_cluster_blueprint':
  command => "/bin/env curl -f -H 'X-Requested-By: ambari' -X POST -u admin:admin $url -d @/tmp/cluster_config.json",
  refreshonly => true
 }

}
