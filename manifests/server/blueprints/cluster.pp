class ambari::server::blueprints::cluster {

 $amb_sever_hostname = $::ambari::params::amb_sever_hostname
 $num_datanodes = $::ambari::params::num_datanodes
 $cluster_name  = $::ambari::params::cluster_name
 $cluster_config= $::ambari::params::cluster_config

 $url = "http://$amb_sever_hostname:8080/api/v1/blueprints/$cluster_name" 

 require ambari::os::packages
 require ambari::server::install

 # Register cluster_config.json
 file {
  'cluster_config_file':
  ensure => 'file',
  content => template("ambari/blueprints/$cluster_config"),
  path => '/tmp/cluster_config.json',
  owner => 'root',
  group => 'root',
  mode  => '0700', # Use 0700 if it is sensitive
  notify => Exec['run_cluster_blueprint'],
 }


 exec {
  'run_cluster_blueprint':
  #command => "echo TESTING >/tmp/test_cluster.out",
  #path => "/usr/bin",

  command => "/bin/env curl -f -H 'X-Requested-By: ambari' -X POST -u admin:admin $url -d @/tmp/cluster_config.json",
  refreshonly => true
 }
}
