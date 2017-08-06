class ambari::os::limits() {

 limits::limits { 'all_users_nofile':
   ensure     => present,
   user       => '*',
   limit_type => 'nofile',
   both       => 65536,
 }
 limits::limits { 'all_users_nproc':
   ensure     => present,
   user       => '*',
   limit_type => 'nproc',
   both       => 65536,
 }
}


