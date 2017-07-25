class ambari::server::db::connector {

 package { postgresql-jdbc:
   ensure => 'installed',
   require => Package['postgresql']
 }

 exec {
  'configure_ambari_postgres_connector':
  command => "ambari-server setup --jdbc-db=postgres --jdbc-driver=/usr/share/java/postgresql-jdbc.jar",
  path => '/usr/sbin/',
  require => [ Package['postgresql-jdbc'] , Class['::ambari::server::service'] ],
  refreshonly => true
 }

}
