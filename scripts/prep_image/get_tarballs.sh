#!/bin/bash


function usage() {
  [ "$1" != "" ] && echo -e "$1"
  echo "usage: `basename $0` <config_file>"
  echo "Gets pupppet modules from the internet"
  echo "Options:"
  echo "   config_file   - see install.conf for an example"
  exit 254
}

function error() {
  echo -e "ERROR: $1"
  exit 254
}

#### SETUP ####

config_file=$1
[ $# -ne 1 ] && usage "Missing required config file."
[ ! -f $1 ] && usage "Config file does not exist: $config_file"

# Set values from the config file
source $config_file


##### SETUP 


RPMS_DIR=$INSTDIR/repo_files/rpms/centos7
FILES_DIR=$INSTDIR/repo_files/files
HDP_DIR=$INSTDIR/repo_files/HDP
AMBARI_DIR=$INSTDIR/repo_files/AMBARI
HDP_UTILS_DIR=$INSTDIR/repo_files/HDP-UTILS

[ "$INSTDIR" = "" ] && error "INSTDIR is not set in the install.conf file"

echo "Downloading missing and newer files only."

mkdir -p $RPMSS_DIR $FILES_DIR $HDP_DIR $AMBARI_DIR $HDP_UTILS_DIR

####################
## RPMS
####################

cd $RPMS_DIR
#### Elasticsearch
wget -N https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.5.noarch.rpm 


####################
## FILES 
####################

cd $FILES_DIR
wget -N " http://central.maven.org/maven2/org/eclipse/jetty/jetty-distribution/9.4.6.v20170531/jetty-distribution-9.4.6.v20170531.tar.gz"


####################
## HDP 
####################

echo "Skipping HDP and Ambari downloads. Uncomment if you want them."

# untar directory files
cd $HDP_DIR
#wget -N http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.6.1.0/HDP-2.6.1.0-centos7-rpm.tar.gz
#wget -N http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.6.0.3/HDP-2.6.0.3-centos7-rpm.tar.gz

cd $AMBARI_DIR
#wget -N http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.5.1.0/ambari-2.5.1.0-centos7.tar.gz

# 'specific' directory files
cd $HDP_UTILS_DIR
#wget -N http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.21/repos/centos7/HDP-UTILS-1.1.0.21-centos7.tar.gz


