class ambari::server::service() {

 service { 'ambari-server':
    ensure => running,
    enable => true
 } 
 
}

