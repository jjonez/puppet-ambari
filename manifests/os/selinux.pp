class ambari::os::selinuix() {

 file { '/etc/selinux/config':
   ensure  => file,
   content => template('ambari/config.erb'),
   notify => Exec['disable_selinix']
 }->
 exec {
   'disable_selinix':
   command => 'setenforce 0',
   refreshonly => true
 }

}

