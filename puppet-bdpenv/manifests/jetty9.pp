class jetty9 {

 # This requires a custom built jetty RPM
 # The RPM can be built from https://github.com/jjonez/jetty9-rpm
 # The file resource for /var/run/jetty is to resolve
 # a permissions issue when running as non-root

 package {'jetty9':
   ensure => 'installed'
 } ->
 file { '/var/run/jetty':
   ensure => 'directory',
   owner  => 'jetty' ,
   mode   => '755',
   require => Class['::ambari::repo::internal', '::ambari::os::jdk']
 }
}
