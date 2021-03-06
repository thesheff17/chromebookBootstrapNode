#!/bin/bash

echo "bootstrap.sh started..."

# vars we can change quickly
GOLANG=go1.15.2
NODEMODULES="serverless typescript express"
PIPPACKAGES="ansible boto3"

SECONDS=0

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# packages
apt-get update 
apt-get upgrade -y
apt-get install -y \
    apt-transport-https \
    curl \
    default-mysql-server \
    g++ \
    gcc \
    git \
    gnupg2 \
    htop \
    locate \
    make \
    python3 \
    python3-dev \
    python3-pip \
    software-properties-common \
    ssh \
    sudo \
    tmux \
    vim \
    wget 

# global pip packages
pip3 install $PIPPACKAGES

# node and yarn
curl -sL https://deb.nodesource.com/setup_12.x | bash -
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
apt-get install -y nodejs yarn
npm install -g $NODEMODULES

# postgres
sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
apt-get update
apt-get -y install postgresql

# golang
wget -q https://dl.google.com/go/$GOLANG.linux-amd64.tar.gz
tar -C /usr/local -xzf $GOLANG.linux-amd64.tar.gz

# rust
curl https://sh.rustup.rs -sSf | sh -s -- -y

# deno
curl -fsSL https://deno.land/x/install/install.sh | sh

# .bashrc entries and home dir changes
echo 'export PATH=$PATH:/usr/local/go/bin' >> /root/.bashrc
echo 'source $HOME/.cargo/env' >> /root/.bashrc

# echo 'export PATH=$PATH:$HOME/.cargo/bin' >> /root/.bashrc
# looping through home directories and adding things to .bashrc
for f in /home/*; do
    if [ -d "$f" ]; then
        echo 'export PATH=$PATH:/usr/local/go/bin' >> $f/.bashrc
        user=$(echo $f | sed 's:.*/::')
        su - $user -c 'curl https://sh.rustup.rs -sSf | sh -s -- -y'
        echo 'source $HOME/.cargo/env' >> $f/.bashrc
    fi
done

# vscode
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
apt-get update
apt-get install code -y

# update database
updatedb

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
echo "bootstrap.sh completed"
