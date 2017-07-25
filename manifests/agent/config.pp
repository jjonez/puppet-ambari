# == Class: ambari::agent::config
class ambari::agent::config inherits ambari {

 # Configure ambari-agent.ini
 file { '/etc/ambari-agent/conf/ambari-agent.ini':
   ensure  => 'file',
   owner   => 'root',
   group   => 'root',
   mode    => '0640',
   content => template('ambari/ambari-agent.ini.erb'),
   require => Class['::ambari::agent::install'],
   notify  => Service['ambari-agent']
 }
}

