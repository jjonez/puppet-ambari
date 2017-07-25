class ambari::server::db::hdpdb {

 # Configure Databases for Postgres
 file {
  '/tmp/configure_hdp_db_script.sh' :
  ensure => 'file',
  content => template('ambari/configure_hdp_db.sh.erb'), 
  owner => 'root',
  group => 'root',
  mode  => '0744',
  require => Class['::ambari::server::db::pgsql'],
#  require => Exec['run_configure_postgres_hdp_script'],
  notify => Exec['run_configure_hdp_db_script'],
 }

 exec {
  'run_configure_hdp_db_script':
  command => "/bin/bash /tmp/configure_hdp_db_script.sh",
  refreshonly => true
 }
}
