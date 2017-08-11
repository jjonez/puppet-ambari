#!/bin/env bash



function usage() {
  [ "$1" != "" ] && echo -e "$1"
  echo "usage: `basename $0` <config_file>"
  echo "Options:"
  echo "  config_file   -  see install.conf for an example"
  exit 254
}

function error() {
  echo -e "ERROR: $1"
  exit 254
}


config_file=$1
[ $# -ne 1 ] && usage "Missing required config file."
[ ! -f $1 ] && usage "Config file does not exist: $config_file"

# Set values from the config file
source $config_file


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

