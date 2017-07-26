class ambari::agent::service() {
  
 service { 'ambari-agent':
    ensure => 'running',
    enable => true,
    require => Class['::ambari::agent::config']
 }
 
}
