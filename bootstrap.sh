#!/bin/bash
# set -e

echo "bootstrap.sh started..."

# we can set versions here
NODEJS="v12.16.3"

CORES=`grep 'cpu cores' /proc/cpuinfo | wc -l`
echo "number of cores is $CORES"

clear

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# packages
apt-get update 
apt-get upgrade -y
apt-get install -y python3 g++ make wget vim tmux python software-properties-common apt-transport-https wget sudo gnupg2 git

# nodejs
wget https://nodejs.org/dist/$NODEJS/node-$NODEJS.tar.gz
tar -xf node-$NODEJS.tar.gz
cd node-$NODEJS
./configure
make -j$CORES
make install

# vscode
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
apt-get update
apt-get install code -y

echo "bootstrap.sh completed"