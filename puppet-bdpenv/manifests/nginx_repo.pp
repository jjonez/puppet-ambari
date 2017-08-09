class bdpenv::nginx_repo() {


 $pkg_names = [
       'fontconfig-2.10.95-10.el7.x86_64',
       'fontpackages-filesystem-1.44-8.el7.noarch',
       'gd-2.0.35-26.el7.x86_64',
       'GeoIP-1.5.0-11.el7.x86_64',
       'gperftools-libs-2.4-8.el7.x86_64',
       'libjpeg-turbo-1.2.90-5.el7.x86_64',
       'libpng-1.5.13-7.el7_2.x86_64',
       'libunwind-1.1-5.el7_2.2.x86_64',
       'libX11-1.6.3-3.el7.x86_64',
       'libX11-common-1.6.3-3.el7.noarch',
       'libXau-1.0.8-2.1.el7.x86_64',
       'libxcb-1.11-4.el7.x86_64',
       'libXpm-3.5.11-3.el7.x86_64',
       'libxslt-1.1.28-5.el7.x86_64',
       'nginx-1.10.2-1.el7.x86_64',
       'nginx-all-modules-1.10.2-1.el7.noarch',
       'nginx-filesystem-1.10.2-1.el7.noarch',
       'nginx-mod-http-geoip-1.10.2-1.el7.x86_64',
       'nginx-mod-http-image-filter-1.10.2-1.el7.x86_64',
       'nginx-mod-http-perl-1.10.2-1.el7.x86_64',
       'nginx-mod-http-xslt-filter-1.10.2-1.el7.x86_64',
       'nginx-mod-mail-1.10.2-1.el7.x86_64',
       'nginx-mod-stream-1.10.2-1.el7.x86_64',
       'perl-5.16.3-291.el7.x86_64',
       'perl-Carp-1.26-244.el7.noarch',
       'perl-constant-1.27-2.el7.noarch',
       'perl-Encode-2.51-7.el7.x86_64',
       'perl-Exporter-5.68-3.el7.noarch',
       'perl-File-Path-2.09-2.el7.noarch',
       'perl-File-Temp-0.23.01-3.el7.noarch',
       'perl-Filter-1.49-3.el7.x86_64',
       'perl-Getopt-Long-2.40-2.el7.noarch',
       'perl-HTTP-Tiny-0.033-3.el7.noarch',
       'perl-libs-5.16.3-291.el7.x86_64',
       'perl-macros-5.16.3-291.el7.x86_64',
       'perl-parent-0.225-244.el7.noarch',
       'perl-PathTools-3.40-5.el7.x86_64',
       'perl-Pod-Escapes-1.04-291.el7.noarch',
       'perl-podlators-2.5.1-3.el7.noarch',
       'perl-Pod-Perldoc-3.20-4.el7.noarch',
       'perl-Pod-Simple-3.28-4.el7.noarch',
       'perl-Pod-Usage-1.63-3.el7.noarch',
       'perl-Scalar-List-Utils-1.27-248.el7.x86_64',
       #'perl-Socket-2.010-4.el7.x86_64',
       'perl-Storable-2.45-3.el7.x86_64',
       'perl-Text-ParseWords-3.29-4.el7.noarch',
       'perl-threads-1.87-4.el7.x86_64',
       'perl-threads-shared-1.43-6.el7.x86_64',
       'perl-Time-HiRes-1.9725-3.el7.x86_64',
       'perl-Time-Local-1.2300-2.el7.noarch'
  ]

 
 file { '/var/lib/puppet-bdpenv/':
   ensure  => 'directory'
 } ->
 file {'copy rpms':
   source => 'puppet:///modules/bdpenv/nginx_rpms',
   path   => '/var/lib/puppet-bdpenv/nginx_rpms',
   sourceselect => 'all',
   recurse      => 'remote'
 } 
 $pkg_names.each |String $pkg_name| {
   package {$pkg_name:
    provider => 'rpm',
    source => "/var/lib/puppet-bdpenv/nginx_rpms/${pkg_name}.rpm", 
    ensure => 'installed',
    install_options => [ '--nodeps', '--nodigest' ],
   }
 } 

 file { ['/var/www/','/var/www/html','/var/www/html/repos']:
    ensure  => 'directory'
 } ->
 file {'/etc/nginx/nginx.conf':
   source  => 'puppet:///modules/bdpenv/nginx_conf/nginx.conf',
   path    =>'/etc/nginx/nginx.conf',
   ensure  => 'file'
 } ->
 file {'/etc/nginx/conf.d/repo.conf':
   source  => 'puppet:///modules/bdpenv/nginx_conf/repo.conf',
   path    =>'/etc/nginx/conf.d/repo.conf',
   ensure  => 'file'
 } ->
 service { 'nginx':
   ensure => 'running',
   enable => 'true'
 }
}
