class ambari::db::hdpdb() {

 file {
   '/var/lib/puuppet-ambari/configure_hdp_db_script.sh' :
   ensure => 'file',
   content => template('ambari/db/configure_hdp_db.sh.erb'), 
   owner => 'root',
   group => 'root',
   mode  => '0744',
   require => Class['::ambari::db::pgsql'],
   notify => Exec['run_configure_hdp_db_script'],
 } ->
 exec {
  'run_configure_hdp_db_script':
  command => "/bin/bash /var/lib/puuppet-ambari/configure_hdp_db_script.sh",
  refreshonly => true
 }

}
