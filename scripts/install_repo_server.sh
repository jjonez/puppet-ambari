#!/bin/bash

function error() {
  echo -e "ERROR: $1"
  exit 254
}


function usage() {
  [ "$1" != "" ] && echo -e "$1"
  echo "usage: `basename $0` <config_file>"
  echo "Installs nginx and configure it for serving files. Must be run as root."
  echo "This requirees that port 80 be open for http and DNS is configured."
  echo "You should set the REPO_DOC_ROOT in install.conf. "
  echo "  REPO_DOC_ROOT is the directory where files will be located."
  echo    "Default is /var/www/html/repos"
  echo "Options:"
  echo "  config_file   -  see install.conf for an example"
  exit 254
}

#### SETUP ####

config_file=$1
[ $# -ne 1 ] && usage "Missing required config file." 
[ ! -f $1 ] && usage "Config file does not exist: $config_file"

# Set values from the config file
source $config_file


RPMDIR=$INSTDIR/packages
TEMPLATES=$INSTDIR/templates

[ "$REPO_DOC_ROOT" = "" ] && usage "REPO_DOC_ROOT is not set in the install.conf file"

[ ! -d $TEMPLATES ] && error "The directory structure is not correct - templates"
[ ! -d $RPMDIR/nginx-rpms ] && error "The directory structure is not correct - rpms,nginx"
[ ! -d $RPMDIR/createrepo ] && error "The directory structure is not correct - rpms,createrepo"

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
yum -y -d 1 localinstall $RPMDIR/nginx-rpms/*
yum -y -d 1 localinstall $RPMDIR/createrepo/*

configure_nginx
mkdir -p ${REPO_DOC_ROOT}

systemctl start nginx
systemctl enable nginx

test_server

echo ""
echo "SUCCESS: COMPLETED CONFIGURATION OF FILE SERVER ON http://${HOSTNAME}:80"
