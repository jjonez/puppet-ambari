class bdpenv::nginx() {

 # Install and configure nginx from local rpms.


 package { 'nginx':
    ensure => 'installed'
 } ->
 service { 'nginx':
   ensure => 'running',
   enable => 'true'
 }
}
