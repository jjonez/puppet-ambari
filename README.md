# ambari

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with hdpdeploy](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with ambari](#beginning-with-ambari)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Authors](#authors)

## Description

## Setup

### Setup Requirements 
To use only the Ambari and HDP puppet module, skip to the section about the Ambari module.

This section describes a setup that creates a yum repo from a couple of prepared CDs (not included in this repository). 
These CDs include rpms for several additional components as well as Ambari, HDP and HDP-UTILS. These RPMs are used
to create an internal repository using the scripts in the "scripts" directory of this project. 

Scripts in the "scripts" directory are as follows. Each requires a directory input. Run without args for usage:

install_puppetlabs_modules.sh  - installs several puppet modules to production environment  

install_repo_server.sh  - installs nginx and configures it on port 80 as a yum repositor server

prepare_repo_server.sh  - installs rpms. Run this for each CD.



The CDs must have the following directory structure:

Repository disks must contain the following directory structure for the script to create the Yum repo correctly:
repo_files/rpms    -- Misc RPMS  
repo_files/packages/nginx-rpms   -- RPMS for nginx  
repo_files/packages/createrepo   -- RPMS for createrepo  
repo_files/dl/hdp/AMBARI   -- tarball for Ambari RPMs downloaded from Hortonworks  
repo_files/dl/hdp/HDP   -- tarball for HDP RPMs downloaded from Hortonworks  
repo_files/dl/hdp/HDP-UTILS   -- tarball for HDP Utils RPMs downloaded from Hortonworks  

### Beginning with ambari

## Usage for the ambari module

cd /etc/puppetlabs/code/environments/production/modules/   

git clone https://github.com/jjonez/puppet-hdpdeploy 

vi /etc/puppetlabs/code/environments/production/manifests/site.pp  


node 'puppetclient1' {  
 include ambari  

  class { 'ambari::os':} ->  
  class { 'ambari::repo':} ->  
  class { 'ambari::agent':} ->  
  class { 'ambari::server':} ->  
  class { 'ambari::db':} ->  
  class { 'ambari::blueprint':}  

}  

# node default {}       # uncomment this line if it doesn't already exist in your manifest  

## Authors

Ed Gleeck
Nasheb Ismaily  
James Jones 
