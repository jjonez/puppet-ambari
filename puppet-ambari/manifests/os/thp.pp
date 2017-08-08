class ambari::os::thp() {

 file {
   'disable_thp_script':
   ensure => 'file',
   source => 'puppet:///modules/ambari/os/disable_thp_script.sh',
   path => '/var/lib/puppet-ambari/disable_thp_script.sh',
   owner => 'root',
   group => 'root',
   mode  => '0744',
   notify => Exec['run_disable_thp_script'],
 } ->
 exec {
   'run_disable_thp_script':
   command => '/var/lib/puppet-ambari/disable_thp_script.sh',
   refreshonly => true
 } ->
 file { '/etc/rc.local':
   ensure  => file,
   content => template('ambari/os/rc.local.erb'),
 }

}

