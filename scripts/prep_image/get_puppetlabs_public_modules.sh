#!/bin/bash



# Set values from the config file
. $(readlink -f $(dirname $0))/../install.conf

function error() {
  echo "ERROR: $1"
  exit 254
}

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
