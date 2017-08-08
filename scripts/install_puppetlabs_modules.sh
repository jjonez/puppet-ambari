#!/bin/env bash

INSTDIR=/root/CD
PMODS=$INSTDIR/puppet_modules
PUPCMD="/opt/puppetlabs/bin/puppet"
TARGET_ENV=production

# space delimited list of puppet modules to install
PUPMODS="puppetlabs-stdlib-4.17.1.tar.gz saz-limits-2.5.0.tar.gz"

[ `whoami` != 'root' ] && {
   echo You must be root to run this script;
   exit 255;
  }

for module in $PUPMODS; do
  $PUPCMD module install $PMODS/$module --environment $TARGET_ENV --ignore-dependencies
done

