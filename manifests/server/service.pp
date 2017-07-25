class ambari::server::service {
  
 service { 'ambari-server':
    ensure => 'running',
    require => Class['::ambari::server::install'],
 #require => Exec['run_configure_postgres_hdp_script']

 }
 
}
