#!/usr/bin/env bash

echo "### RozoFS dependencies installation"
apt-get update
apt-get install -y git
apt-get install -y gcc make cmake libfuse-dev libattr1-dev uuid-dev libconfig-dev libreadline-dev pyro python2.7-dev python-yaml rpcbind swig


echo "### RozoFS core installation"
mkdir git && cd git
git clone http://github.com/rozofs/rozofs.git
cd rozofs/ && mkdir build && cd build/
cmake ..
make
make install

echo "### RozoFS configuration and running"
rozo agent start
rozo volume expand localhost localhost localhost localhost -E localhost
rozo export create -E localhost 1
rozo export mount -E localhost
rozo node start -E localhost
