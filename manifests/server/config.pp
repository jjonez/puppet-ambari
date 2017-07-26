class ambari::server::config {

 # Run ambari's inital setup 

 $java_home =  $::ambari::params::java_home

 # Iinitial setup ambari server
 file { 
  'ambari_setup_script' :
  ensure => 'file',
  source => 'puppet:///modules/ambari/ambari_setup_script.exp',
  path => '/tmp/ambari_setup_script.exp',
  owner => 'root',
  group => 'root',
  mode  => '0744',
  #require => Package['ambari-server'],
  require => Class['::ambari::server::install'],
  notify => Exec['run_ambari_server_setup'],
 }

 exec {
  'run_ambari_server_setup':
  command => "/tmp/ambari_setup_script.exp ${java_home} | tee /tmp/ambari_setup_script.exp.log",
  refreshonly => true
 }

}
