#!/bin/env bash

# Set values from the config file
. $(readlink -f $(dirname $0))/install.conf

PMODS=$INSTDIR/puppet_modules
PUPCMD="/opt/puppetlabs/bin/puppet"
TARGET_ENV=production

function error() {
  echo "ERROR: $1"
  exit 254
}

function usage() {
  [ "$1" != "" ] && echo "$1"
}

[ ! -d $PMODS ] && error "Source puppet modules directory does not exist: $PMODS"
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

