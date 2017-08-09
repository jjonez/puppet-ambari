#!/bin/env bash

#Args: <ambari_host> [<expected number of hosts> <max_times_to_check>]

ambari_host=${1}
expected_hosts=${2:-1}   #how many hosts should be registered
max_wait=${3:-10}        #default to 10


# Determine how long to wait.
if [ $expected_hosts -le 10 ];then
  # minimum 10
  max_wait=10
else
  # calculate a value for more hosts
  calc_val=$(($expected_hosts * 1))
  max_wait=${3:-${calc_val}} 
fi

checks=0
found=0
url=http://$ambari_host:8080/api/v1/hosts

while [ $found -lt $expected_hosts ];do
  let "checks++"
  echo TEST >/tmp/junk1
  found=`curl -s  -H "X-request-by: ambari" -u admin:admin $url |egrep '[ ]{1,}"host_name"'|awk '{print $3}' |tee /tmp/wait_for_agents_to_register.sh.out |wc -l`

  if [ $found -eq $expected_hosts ];then 
     break; 
  elif [ $max_wait -le $checks ];then
    echo "ERROR: Waiting for hosts to register. Expecting $expected_hosts. Found $found."
     exit 255
  else
    echo "INFO: Waiting for hosts to register. Expecting $expected_hosts. Found $found."
    sleep 1 
  fi
done
