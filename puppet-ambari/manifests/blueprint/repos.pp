class ambari::blueprint::repos() {

 $ambari_server      = $::ambari::blueprint::ambari_server
 $ambari_server_port = $::ambari::blueprint::ambari_server_port
 $hdp_stack_version  = $::ambari::blueprint::hdp_stack_version
 $hdp_repo_url       = $::ambari::blueprint::hdp_repo_url
 $hdp_utils_repo_url = $::ambari::blueprint::hdp_utils_repo_url

 #$url = "http://${ambari_server}:${ambari_server_port}/api/v1/blueprints/${cluster_name}" 
 $url_hdp = "http://${ambari_server}:${ambari_server_port}/api/v1/stacks/HDP/versions/2.6/operating_systems/redhat7/repositories/HDP-2.6"
 $url_hdp_utils = "http://${ambari_server}:${ambari_server_port}/api/v1/stacks/HDP/versions/2.6/operating_systems/redhat7/repositories/HDP-UTILS-1.1.0.21"

 file {
   'hdp_repo_file':
   ensure => 'file',
   content => template("ambari/blueprint/hdp_repo.json"),
   path => '/var/lib/puppet-ambari/hdp_repo.json',
   owner => 'root',
   group => 'root',
   mode  => '0700',
   notify => Exec['run_hdp_repo_blueprint'],
 } -> 
 exec {
  'run_hdp_repo_blueprint':
  command => "/bin/env curl -f -H 'X-Requested-By: ambari' -X PUT -u admin:admin $url_hdp -d @/var/lib/puppet-ambari/hdp_repo.json",
  refreshonly => true
 } 

 file {
   'hdp_utils_repo_file':
   ensure => 'file',
   content => template("ambari/blueprint/hdp_utils_repo.json"),
   path => '/var/lib/puppet-ambari/hdp_utils_repo.json',
   owner => 'root',
   group => 'root',
   mode  => '0700',
   notify => Exec['run_hdp_utils_repo_blueprint'],
 } -> 
 exec {
  'run_hdp_utils_repo_blueprint':
  command => "/bin/env curl -f -H 'X-Requested-By: ambari' -X PUT -u admin:admin $url_hdp_utils -d @/var/lib/puppet-ambari/hdp_utils_repos.json",
  refreshonly => true
 }


}
