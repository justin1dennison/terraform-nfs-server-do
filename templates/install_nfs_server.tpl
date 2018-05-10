#!/bin/bash

sudo apt-get install -y nfs-kernel-server
sudo mkdir -p ${mount_point}
sudo chmod 777 /etc/exports /etc/hosts.allow ${mount_point}
sudo echo "/export/files *(rw,no_root_squash)" >>  /etc/exports
sudo echo "rspbind = ALL
portmap = ALL
nfs = ALL" >> /etc/hosts.allow
sudo chmod 755 /etc/exports /etc/hosts.allow
sudo /etc/init.d/nfs-kernel-server restart
sudo showmount -e
sudo echo "hi there this is the server $(hostname)" > ${mount_point}/test.txt