#!/bin/bash


function usage() {
  [ "$1" != "" ] && echo -e "$1"
  echo "usage: `basename $0` <disk_dir>"
  echo "Gets some larger rpms from the internet. This is only used"
  echo "to get artifacts for the CD"
  echo "Arguments:"
  echo "  disk_dir        - directory contianing the repo_files directory."
  echo "                    this can be the disk mount point or a copy."
  echo "                    It must contiain the 'repo_files' directory. e.g. /mnt/cdrom"
  exit 254
}

function error() {
  echo -e "ERROR: $1"
  exit 254
}

#### SETUP ####

[ $# -lt 1 ] && usage "Missing required disk_dir."

INSTDIR=$1
[ "$2" != "" ] && REPO_DOC_ROOT=$2



##### SETUP 


RPMS_DIR=$INSTDIR/repo_files/rpms
RPMS_DL_DIR=$INSTDIR/repo_files/dl/rpms
FILES_DL_DIR=$INSTDIR/repo_files/dl/files
HDP_DIR=$INSTDIR/repo_files/dl/HDP
AMBARI_DIR=$INSTDIR/repo_files/dl/AMBARI
HDP_UTILS_DIR=$INSTDIR/repo_files/dl/HDP-UTILS

[ "$INSTDIR" = "" ] && error "INSTDIR is not set in the install.conf file"

echo "Downloading missing and newer files only."

mkdir -p $RPMS_DIR $RPMS_DL_DIR $FILES_DIR $HDP_DIR $AMBARI_DIR $HDP_UTILS_DIR

which wget &>/dev/null
if [ $? -ne 0 ];then
   error "wget must be installed."
fi

####################
## RPMS
####################

cd $RPMS_DL_DIR
#### Elasticsearch
wget -N https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.5.noarch.rpm 


####################
## FILES 
####################

cd $FILES_DL_DIR
wget -N " http://central.maven.org/maven2/org/eclipse/jetty/jetty-distribution/9.4.6.v20170531/jetty-distribution-9.4.6.v20170531.tar.gz"


####################
## HDP 
####################

echo "Skipping HDP and Ambari downloads. Uncomment if you want them."

# untar directory files
echo Writing file to: $HDP_DIR
cd $HDP_DIR
#wget -N http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.6.1.0/HDP-2.6.1.0-centos7-rpm.tar.gz
wget -N http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.6.0.3/HDP-2.6.0.3-centos7-rpm.tar.gz

echo Writing file to: $AMBARI_DIR
cd $AMBARI_DIR
wget -N http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.5.1.0/ambari-2.5.1.0-centos7.tar.gz

echo Writing file to: $HDP_UTILS_DIR
cd $HDP_UTILS_DIR
wget -N http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.21/repos/centos7/HDP-UTILS-1.1.0.21-centos7.tar.gz


