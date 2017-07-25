class ambari::agent::service {
  
 # Start ambari-agent and make sure it stays on
 service { 'ambari-agent':
    ensure => 'running',
    require => Class['::ambari::agent::config'],
    enable => true
 }
 
}
