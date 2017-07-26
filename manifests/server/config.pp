class ambari::server::config {

 # Run ambari's inital setup 

 $java_home =  '/usr/lib/jvm/java-1.8.0-openjdk'

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
  command => "/tmp/ambari_setup_script.exp ${java_home}",
  refreshonly => true
 }

}
