class ambari::server::config() {

 $java_home = $::ambari::server::java_home

 file { 
   'ambari_setup_script' :
   ensure => 'file',
   source => 'puppet:///modules/ambari/server/ambari_setup_script.exp',
   path => '/tmp/ambari_setup_script.exp',
   owner => 'root',
   group => 'root',
   mode  => '0777',
   require => Class['::ambari::server::install'],
   notify => Exec['run_ambari_server_setup_script']
 } ->
 exec {
  'run_ambari_server_setup_script':
  command => "/tmp/ambari_setup_script.exp ${java_home}"
 }

}
