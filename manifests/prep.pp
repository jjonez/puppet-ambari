class ambari::prep { 
 
  # working directory
  file { '/var/lib/puuppet-ambari':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  } 

}

