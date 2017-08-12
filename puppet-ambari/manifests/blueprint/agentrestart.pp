class ambari::blueprint::agentrestart() {

# This is more of a hack. It has been determined that
# elastic search cannot be started by ambari unless the agent
# is restarted. This is due a non-root for ambari. Even if the
# commands are entered in the sudoer's file, ambari agent does 
# not pick it up (it would seem) unless the process is restarted.
#
# Research needs to be to done for a root cause analysis

 exec {'restart ambari-agent':
    command => '/sbin/service ambari-agent restart',
    unless   => 'test -f /var/lib/puppet-ambari/hdp_utils_repo.json',
    path => '/usr/bin:/bin'
  } 

}
