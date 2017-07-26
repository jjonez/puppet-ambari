class ambari::db(

)inherits ::ambari::params {

  contain ambari::db::pgsql
  contain ambari::db::hdpdb
  contain ambari::db::connector

  Class[::ambari::db::pgsql] ->
  Class[::ambari::db::hdpdb] ->
  Class[::ambari::db::connector]

}

