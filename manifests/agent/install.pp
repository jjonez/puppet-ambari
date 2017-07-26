class ambari::agent::install() {

 package {'ambari-agent':
   ensure => 'installed'
 }

}
