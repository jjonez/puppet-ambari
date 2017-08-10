#!/bin/bash

# Set values from the config file
. $(readlink -f $(dirname $0))/../install.conf

function error() {
  echo "ERROR: $1"
  exit 254
}

[ "$INSTDIR" = "" ] && error "INSTDIR is not set in the install.conf file"


asis_target=$INSTDIR/tarballs/asis

unset asis_urls
asis_urls+=" http://central.maven.org/maven2/org/eclipse/jetty/jetty-distribution/9.4.6.v20170531/jetty-distribution-9.4.6.v20170531.tar.gz"


untar_target=$INSTDIR/tarballs/untar

unset untar_urls
#untar_urls+=" http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.6.1.0/HDP-2.6.1.0-centos7-rpm.tar.gz"
#untar_urls+=" http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.6.0.3/HDP-2.6.0.3-centos7-rpm.tar.gz"
untar_urls+=" http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.21/repos/centos7/HDP-UTILS-1.1.0.21-centos7.tar.gz"
#untar_urls+=" http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.5.1.0/ambari-2.5.1.0-centos7.tar.gz"

function get_tars() {

  local l_urls="$1"
  local l_target="$2"

  mkdir -p $l_target >/dev/null
  cd $l_target

  for url in $l_urls;do
     echo "DEBUG: wget -N $url"
     wget -N $url
  done
}

TARGET=$INSTDIR/tarballs/asis

get_tars "$asis_urls" "$asis_target"
get_tars "$untar_urls" "$untar_target"

