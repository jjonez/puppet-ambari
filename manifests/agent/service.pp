class ambari::agent::service() {
  
 service { 'ambari-agent':
    ensure => 'running',
    enable => true,
    hasrestart => true,
    hasstatus  => true,
    require => Class['::ambari::agent::config']
 }
 
}
