class ambari::server::install() {

 package {'ambari-server':
   ensure => 'installed'
 }

}
