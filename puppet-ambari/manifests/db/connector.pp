class ambari::db::connector() {

 package { postgresql-jdbc:
   ensure => 'installed',
   require => Package['postgresql'],
   notify => Exec['configure_ambari_postgres_connector']
 } ->
 exec {
   'configure_ambari_postgres_connector':
   command => "/usr/sbin/ambari-server setup --jdbc-db=postgres --jdbc-driver=/usr/share/java/postgresql-jdbc.jar",
   path => '/usr/sbin/',
   require => Class['::ambari::server::config'],
   refreshonly => true
 }

}
