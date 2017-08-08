class ambari::agent::install() {

 package {'ambari-agent':
   ensure => 'installed',
   require => Class['::ambari::os::ambari_user_prep']
 }

}
