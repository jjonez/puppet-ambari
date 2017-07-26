# Class: ambari::server 
class ambari::server inherits ambari {
    include ambari::server::install
    include ambari::server::config
    include ambari::server::service
    include ambari::server::db::pgsql
    include ambari::server::db::hdpdb
    include ambari::server::db::connector
    include ambari::server::blueprints::cluster
    include ambari::server::blueprints::hostmap
}

