# == Class: ambari::selinux
class ambari::os::selinux inherits ambari {

 # Disable Transparent Hugepage in Current Session
 exec {
  'disable_selinix':
  command => 'setenforce 0',
  refreshonly => true
 }

 # Disable SELINUX
 file { '/etc/selinux/config':
  ensure  => file,
  content => template('ambari/config.erb'),
 }

}

