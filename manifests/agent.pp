# Class: ambari::agent
class ambari::agent {
    include ambari::agent::install
    include ambari::agent::config
    include ambari::agent::service
}

