class bdpenv::jetty9() inherits ambari::params  {

 # This requires a custom built jetty RPM
 # The RPM can be built from https://github.com/jjonez/jetty9-rpm
 # The file resource for /var/run/jetty is to resolve
 # a permissions issue when running as non-root

# require 'ambari::params'
 
 $internal_repo_url = $::ambari::params::internal_repo_url

 if $internal_repo_url != undef and $internal_repo_url != "" {
    yumrepo { 'internal2':
     descr    => 'internal repo',
     enabled  => 1,
     baseurl  => "${internal_repo_url}",
     gpgcheck => 0,
   }
 }

 package {'jetty9':
   ensure => 'installed',
 } ->
 file { '/var/run/jetty':
   ensure => 'directory',
   owner  => 'jetty' ,
   mode   => '755',
 } ->
 service {'jetty9':
   ensure => 'running',
   enable => 'true'
 }
}
