class ambari::server::blueprints::hostmap {

 $amb_sever_hostname = $::ambari::params::amb_sever_hostname
 $cluster_name       = $::ambari::params::cluster_name
 $hostmap_config     = $::ambari::params::hostmap_config

 $url = "http://$amb_sever_hostname:8080/api/v1/clusters/$cluster_name"

 require ambari::os::packages
 require ambari::server::install

 # Register the hosts map
 file {
  'hostmapping_file':
  ensure => 'file',
  content => template("ambari/blueprints/$hostmap_config"),
  path => '/tmp/hostmap.json',
  owner => 'root',
  group => 'root',
  mode  => '0700', # Use 0700 if it is sensitive
  notify => Exec['run_hostmap_blueprint'],
 }


 exec {
  'run_hostmap_blueprint':
  #command => "echo TESTING >/tmp/test_hostmap.out",
  #path    => "/usr/bin",

  command => "/bin/env curl -f -H 'X-Requested-By: ambari' -X POST -u admin:admin $url -d @/tmp/hostmap.json",
  refreshonly => true
 }

}
