# == Class: ambari::server::install
class ambari::server::install inherits ambari {


 # Install ambari agent
 package {'ambari-server':
   ensure => 'installed'
 }

}
