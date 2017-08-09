#!/bin/bash

INSTDIR=/root/CD
PMODS=$INSTDIR/puppet_modules

urls="
https://forge.puppet.com/v3/files/puppetlabs-stdlib-4.17.1.tar.gz
https://forge.puppet.com/v3/files/saz-limits-2.5.0.tar.gz
"

yum install -y wget

mkdir -p $PMODS 2>/dev/null
cd $PMODS

for url in $urls;do
   wget $url
done
