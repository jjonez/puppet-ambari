class ambari::blueprint::wait_for_agents() {

 $ambari_server     = ambari::blueprint::num_ambari_agents
 $num_ambari_agents = ambari::blueprint::num_ambari_agents

 file {
   'wait_for_agents_script':
   ensure => 'file',
   source => 'puppet:///modules/ambari/blueprints/wait_for_agents_to_register.sh',
   path => '/var/lib/puppet-ambari/wait_for_agents_to_register.sh',
   owner => 'root',
   group => 'root',
   mode  => '0744'
   #notify => Exec['wait_for_agents_to_register'],
 } ->
 exec {
   'wait_for_agents_to_register':
   command => "/var/lib/puppet-ambari/wait_for_agents_to_register.sh $ambari_server $num_ambari_agents",
   refreshonly => true
 } 

}

