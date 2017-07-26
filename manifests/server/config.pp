class ambari::server::config() {

 $java_home = $::ambari::server::java_home

 exec {
   'run_ambari_server_setup_script':
   command => "/usr/sbin/ambari-server setup -j ${java_home} -s",
   require => Class['::ambari::server::install']
 }

}
