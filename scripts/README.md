
On a server that will become a yum repo and file server:


- First create the repository server. This will install and configure nginx.

install_repo_server.sh install
 

- Next populate the repository server with files.


prepare_repo_server.sh install
