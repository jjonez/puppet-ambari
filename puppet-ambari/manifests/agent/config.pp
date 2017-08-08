class ambari::agent::config() {

 $ambari_server           = $::ambari::agent::ambari_server
 $ambari_server_port      = $::ambari::agent::ambari_server_port
 $ambari_comm_port        = $::ambari::agent::ambari_comm_port
 $ambari_comm_secure_port = $::ambari::agent::ambari_comm_secure_port

 $ambari_user  = $::ambari::os::ambari_user

 file { '/etc/ambari-agent/conf/ambari-agent.ini':
   ensure  => 'file',
   owner   => 'root',
   group   => 'root',
   mode    => '0755',
   content => template('ambari/agent/ambari-agent.ini.erb'),
   require => Class['::ambari::agent::install'],
   notify  => Service['ambari-agent']
 }

}

