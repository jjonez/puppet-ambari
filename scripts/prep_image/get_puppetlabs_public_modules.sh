#!/bin/bash


function usage() {
  [ "$1" != "" ] && echo -e "$1"

  echo "usage: `basename $0` <disk_dir>"
  echo "Gets pupppetlab modules from the internet. This is only used"
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

config_file=$1
[ $# -ne 1 ] && usage "Missing required config file."
[ ! -f $1 ] && usage "Config file does not exist: $config_file"

# Set values from the config file
source $config_file


[ "$INSTDIR" = "" ] && error "INSTDIR is not set in the install.conf file"

function get_tars() {

  local l_urls="$1"

  mkdir -p $TARGET >/dev/null
  cd $TARGET

  for url in $l_urls;do
     wget -N $url
  done
}


TARGET=$INSTDIR/puppet_modules

unset urls
urls+=" https://forge.puppet.com/v3/files/puppetlabs-stdlib-4.17.1.tar.gz"
urls+=" https://forge.puppet.com/v3/files/saz-limits-2.5.0.tar.gz"

get_tars "$urls"
