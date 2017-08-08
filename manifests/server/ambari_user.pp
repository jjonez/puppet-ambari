class ambari::server::ambari_user() {

 $ambari_user  = $::ambari::os::ambari_user

 file_line { 'Change user for ambari server':
   path    => '/etc/ambari-server/conf/ambari.properties',  
   line    => "ambari-server.user=${ambari_user}",
   match   => "^ambari-server.user=*$",
   require => Class['::ambari::os::ambari_user_prep'],
 } 

}
