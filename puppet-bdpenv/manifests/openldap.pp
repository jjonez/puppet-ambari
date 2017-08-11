class bdpenv::openldap {

 require ambari::repo::internal

 package {'openldap':
   ensure => 'installed',
 }
}
