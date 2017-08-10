#!/bin/bash


# Set values from the config file
. $(readlink -f $(dirname $0))/install.conf

RPMDIR=$INSTDIR/packages/nginx-rpms
CONFIG=$INSTDIR/templates
TARBALLS=$INSTDIR/tarballs

function error() {
  echo "ERROR: $1"
  exit 254
}

function usage() {
  [ "$1" != "" ] && echo "$1"
  echo "usage: `basename $0` <action> [doc_root]"
  echo " Prepares the REPO_DOC_ROOT folder. ($REPO_DOC_ROOT)."
  echo " You should set the REPO_DOC_ROOT in $config_file. "
  echo " REPO_DOC_ROOT is the directory where files will be located."
  echo "OPTIONS:"
  echo "  action        - e.g. install or help"
  exit 254
}



[ "$REPO_DOC_ROOT" = "" ] && usage "REPO_DOC_ROOT is not set in the install.conf file"
[ "$INSTDIR" = "" ] && error "INSTDIR is not set in the install.conf file"
[ ! -d $TARBALLS ] && error "INSTDIR is not valid in the install.conf file"
[ "$1" != "install" ] && usage ""


# OTHERS
for i in $TARBALLS/asis/*;do
   echo " ------ copying $i --------"
   cp -p $i $REPO_DOC_ROOT
done


# UNTAR
for i in $TARBALLS/untar/*;do
  echo " ------ UNTARRING $i --------"
 tar xzf $i -C $REPO_DOC_ROOT
done




i=HDP-UTILS-1.1.0.21-centos7.tar.gz
echo " ------ UNTARRING $i --------"
target_dir=$REPO_DOC_ROOT/HDP-UTILS-1.1.0.21/centos7
mkdir -p $target_dir
tar xzf $TARBALLS/specific/$i -C $target_dir


