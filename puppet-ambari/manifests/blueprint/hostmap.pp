class ambari::blueprint::hostmap() {

 $ambari_server      = $::ambari::blueprint::ambari_server
 $ambari_server_port = $::ambari::blueprint::ambari_server_port
 $cluster_name       = $::ambari::blueprint::cluster_name
 $hostmap_config     = $::ambari::blueprint::hostmap_config
 $master_nodes       = $::ambari::blueprint::master_nodes
 $worker_nodes       = $::ambari::blueprint::worker_nodes
 $elastic_nodes       = $::ambari::blueprint::elastic_nodes

 $url = "http://${ambari_server}:${ambari_server_port}/api/v1/clusters/${cluster_name}"

 file {
   'hostmapping_file':
   ensure => 'file',
   content => template("ambari/blueprint/$hostmap_config"),
   path => '/var/lib/puppet-ambari/hostmap.json',
   owner => 'root',
   group => 'root',
   mode  => '0700',
   notify => Exec['run_hostmap_blueprint'],
 } ->
 exec {
  'run_hostmap_blueprint':
  command => "/bin/env curl -f -H 'X-Requested-By: ambari' -X POST -u admin:admin $url -d @/var/lib/puppet-ambari/hostmap.json",
  refreshonly => true
 }

}
