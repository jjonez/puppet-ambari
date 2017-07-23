# == Class: ambari::thp
class ambari::os::thp inherits ambari {

 # Disable Transparent Hugepage in Current Session
 file {
  'disable_thp_script':
  ensure => 'file',
  source => 'puppet:///modules/ambari/disable_thp_script.sh',
  path => '/tmp/disable_thp_script.sh',
  owner => 'root',
  group => 'root',
  mode  => '0744', # Use 0700 if it is sensitive
  notify => Exec['run_disable_thp_script'],
 }

 exec {
  'run_disable_thp_script':
  command => '/tmp/disable_thp_script.sh',
  refreshonly => true
 }

 # Disable Transparent Hugepage Permanent
 file { '/etc/rc.local':
  ensure  => file,
  content => template('ambari/rc.local.erb'),
 }

}

