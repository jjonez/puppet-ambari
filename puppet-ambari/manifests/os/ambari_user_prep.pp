class ambari::os::ambari_user_prep() {

 $ambari_user  = $::ambari::os::ambari_user
 $hadoop_group = $::ambari::os::hadoop_group

 if ($ambari_user != 'root') {
   group { "${hadoop_group}":
     ensure => 'present'
   }
   user { "${ambari_user}":
     ensure => 'present',
     groups => "${hadoop_group}",
     shell  => "/bin/bash"
   } ->

   file { '/etc/sudoers.d/ambari':
     ensure  => file,
     owner   => 'root',
     group   => 'root',
     mode    => '440',
     content => template('ambari/os/ambari.sudo.erb')
   } 
 }
}
