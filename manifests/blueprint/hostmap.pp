class ambari::blueprint::hostmap() {

 $ambari_sever_hostname = $::ambari::blueprint::ambari_sever_hostname
 $ambari_server_port = $::ambari::blueprint::ambari_server_port
 $cluster_name = $::ambari::blueprint::cluster_name
 $hostmap_config = $::ambari::blueprint::hostmap_config

 $url = "http://${amb_sever_hostname}:${ambari_server_port}/api/v1/clusters/${cluster_name}"

 file {
   'hostmapping_file':
   ensure => 'file',
   content => template("ambari/blueprint/$hostmap_config"),
   path => '/tmp/hostmap.json',
   owner => 'root',
   group => 'root',
   mode  => '0700',
   notify => Exec['run_hostmap_blueprint'],
 } ->
 exec {
  'run_hostmap_blueprint':
  command => "/bin/env curl -f -H 'X-Requested-By: ambari' -X POST -u admin:admin $url -d @/tmp/hostmap.json",
  refreshonly => true
 }

}
