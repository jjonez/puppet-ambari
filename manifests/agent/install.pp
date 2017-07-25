# == Class: ambari::agent::install
class ambari::agent::install inherits ambari {

 $amb_sever_hostname = $::ambari::params::amb_sever_hostname

 # Install ambari agent
 package {'ambari-agent':
   ensure => 'installed'
 }

}
