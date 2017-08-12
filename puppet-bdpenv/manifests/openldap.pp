class bdpenv::openldap {

 require ambari::repo::internal

 package {'openldap-servers':
   ensure => 'installed',
 } ->
 service {'slapd':
   ensure => 'running',
   enable => 'true'
 }
}