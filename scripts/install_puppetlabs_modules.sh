#!/bin/env bash



function usage() {
  [ "$1" != "" ] && echo -e "$1"
  echo "usage: `basename $0` <disk_dir>"
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


[ $# -lt 1 ] && usage "Missing required disk_dir."

INSTDIR=$1


PMODS=$INSTDIR/puppet_modules
PUPCMD="/opt/puppetlabs/bin/puppet"
TARGET_ENV=production



[ ! -d $PMODS ] &&  error "Source puppet modules directory does not exist: $PMODS"
[ ! -f $PUPCMD ] && error "Puppet command does not exist on this machine: $PUPCMD"


# space delimited list of puppet modules to install
PUPMODS="puppetlabs-stdlib-4.17.1.tar.gz saz-limits-2.5.0.tar.gz"

if [ $EUID -ne 0 ]; then
   echo "This script must be run as root"
   exit 1
fi

for module in $PUPMODS; do
  $PUPCMD module install $PMODS/$module --environment $TARGET_ENV --ignore-dependencies
done

