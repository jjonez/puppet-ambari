#!/bin/bash


retval=

REPO_DOC_ROOT="/var/www/html/repos"

function usage() {
  [ "$1" != "" ] && echo -e "$1"
  echo "usage: `basename $0` <disk_dir> [repo_doc_root]"
  echo " Prepares the rpms in repo_doc_roo folder. (default $REPO_DOC_ROOT)."
  echo "Options:"
  echo "  disk_dir        - directory contianing the repo_files directory."
  echo "                    this can be the disk mount point or a copy."
  echo "                    It must contiain the 'repo_files' directory. e.g. /mnt/cdrom"
  echo "  repo_doc_root   - (optional) default is $REPO_DOC_ROOT."
  echo "                    this is the directory where rpms will be located."
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



[ "$REPO_DOC_ROOT" = "" ] && usage "REPO_DOC_ROOT is not set in the install.conf file"
[ "$INSTDIR" = "" ] && error "INSTDIR is not set in the install.conf file"
[ ! -d $REPO_DOC_ROOT ] && error "The repo doc root does not exist: $REPO_DOC_ROOT.\Please ensure that the repo server is configured."



######## FUNCTIONS ##########

function get_base_pkg_name() {
  base=`basename $1`
  retval=`echo "$base"  |sed -e 's/\(.*\)-centos7.*/\1/g'`
}


function prepare_repos() {
  local l_src_path=$1    #List of paths/files space delimited (e.g. globbed)
  local l_url_suffix=$2  #This is going to come from the structure of the tar dirs

  echo "Untarring repo files (this may take a minute)...."
  for i in $l_src_path ;do
    get_base_pkg_name $i
    base=$retval
    mkdir -p $REPO_DOC_ROOT/$base

    echo " -- UNTARRING $i "
    tar xzf $i -C $REPO_DOC_ROOT/$base

    urls_out+="\n$base  http://${HOSTNAME}/$base/$l_url_suffix"
  done
}

######## MAIN ##########

NGINX_DIR=$INSTDIR/repo_files/packages/nginx-rpms
CREATEREPO_DIR=$INSTDIR/repo_files/packages/createrepo

RPMS_DIR=$INSTDIR/repo_files/rpms
RPMS_DL_DIR=$INSTDIR/repo_files/dl/rpms
FILES_DL_DIR=$INSTDIR/repo_files/dl/files
HDP_DIR=$INSTDIR/repo_files/dl/hdp/HDP
AMBARI_DIR=$INSTDIR/repo_files/dl/hdp/AMBARI
HDP_UTILS_DIR=$INSTDIR/repo_files/dl/hdp/HDP-UTILS


# prepare
  yum_root=$REPO_DOC_ROOT/rpms/centos7
  mkdir -p $REPO_DOC_ROOT/rpms/centos7

# RPMS (regular)
  echo " -- creating yum repo"
  echo "Copying repo files (this may take a minute)...."
  cp -pr $RPMS_DIR/* $yum_root

# RPMS DL
  echo " -- creating yum repo from dl-rpms"
  echo "Copying repo files (this may take a minute)...."
  cp -pr $RPMS_DL_DIR $yum_root

# RPMS nginx
  echo " -- creating yum repo from nginx-rpms"
  echo "Copying repo files (this may take a minute)...."
  cp -pr $NGINX_DIR $yum_root

# RPMS nginx
  echo " -- creating yum repo from createrepo-rpms"
  echo "Copying repo files (this may take a minute)...."
  cp -pr $CREATEREPO_DIR $yum_root


createrepo $yum_root
urls_out+="\nRPMs  http://${HOSTNAME}/rpms/centos7"



# FILES
echo " -- creating files repo"
echo "Copying repo files (this may take a minute)...."
cp -pr $FILES_DIR/files $REPO_DOC_ROOT
#urls_out+="\nFiles http://${HOSTNAME}/files"


# HORTONWORKS REPOS
prepare_repos "$HDP_DIR/*"  "HDP/centos7"
prepare_repos "$AMBARI_DIR/*"  "ambari/centos7"
prepare_repos "$HDP_UTILS_DIR/*"  ""


echo " -------------------------"
echo " ------ REPO URLS --------"
echo -e "$urls_out"



