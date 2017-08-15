#!/bin/bash

REPO_DOC_ROOT="/var/www/html/repos"

function error() {
  echo -e "ERROR: $1"
  exit 254
}

function usage() {
  [ "$1" != "" ] && echo -e "$1"
  echo "usage: `basename $0` <disk_dir> [repo_doc_root]"
  echo "Installs nginx and configure it for serving files. Must be run as root."
  echo "This requirees that port 80 be open for http and DNS is configured."
  echo "Arguments:"
  echo "  disk_dir        - directory contianing the repo_files directory."
  echo "                    this can be the disk mount point or a copy."
  echo "                    It must contiain the 'repo_files' directory. e.g. /mnt/cdrom"
  echo "  repo_doc_root   - (optional) default is $REPO_DOC_ROOT."
  echo "                    this is the directory where rpms will be located."
  exit 254
}

#### SETUP ####

[ $# -lt 1 ] && usage "Missing required disk_dir." 

INSTDIR=$1
[ "$2" != "" ] && REPO_DOC_ROOT=$2



NGINX_DIR=$INSTDIR/repo_files/packages/nginx-rpms
CREATEREPO_DIR=$INSTDIR/repo_files/packages/createrepo


this_dir=$(dirname $(readlink -f $0))
TEMPLATES=${this_dir}/templates

[ "$REPO_DOC_ROOT" = "" ] && usage "REPO_DOC_ROOT is not set in the install.conf file"

[ ! -d $TEMPLATES ] && error "The directory structure is not correct - templates"
[ ! -d $NGINX_DIR ] && error "The directory structure is not correct - rpms,nginx"
[ ! -d $CREATEREPO_DIR ] && error "The directory structure is not correct - rpms,createrepo"

########################
##### FUNCTION FUNCTIONSS 
########################


function test_server() {
  echo "Verifying server is running..."
  sleep 1

  test_file=${REPO_DOC_ROOT}/__test.txt
  echo SUCCESS > $test_file
  result=`curl -s http://localhost:80/__test.txt`
  if [ "$result" != "SUCCESS" ];then
    echo "An error occurred. The server is not availalbe."
    exit 254
  fi

  rm -f $test_file
}

function configure_nginx() {

  cp -p $TEMPLATES/nginx.conf /etc/nginx/.

  conf_file=/etc/nginx/conf.d/repo.conf

  echo "Configuring REPO_DOC_ROOT: ${REPO_DOC_ROOT} in $conf_file"

  cat $TEMPLATES/repo.conf |sed "s#DOC_ROOT#${REPO_DOC_ROOT}#" > /etc/nginx/conf.d/repo.conf
}

########################
##### MAIN 
########################



#### DO INSTALL ####

echo "  ----- About to install rpms  ----"
yum -y -d 1 localinstall $NGINX_DIR/*
yum -y -d 1 localinstall $CREATEREPO_DIR/*

configure_nginx
mkdir -p ${REPO_DOC_ROOT}

systemctl start nginx
systemctl enable nginx

test_server

echo ""
echo "SUCCESS: COMPLETED CONFIGURATION OF FILE SERVER ON http://${HOSTNAME}:80"
echo "Next setp is to prepare_repo_server.sh"
