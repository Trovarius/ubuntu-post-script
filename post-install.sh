#!/bin/bash
#
# Ubuntu post-install script
#
#Author: Luiz Fernando
#
#Usage:
# $ chmod +x post-install.sh
# $ ./post-install.sh
#

function header_mensagem () {
	echo "---------------------------------------"
	echo "=> $1"
	echo "---------------------------------------"

}

header_mensagem "Ubuntu post-install script"

# Install base software
header_mensagem "Instaling base libraries"
sudo apt-get install -y build-essential libssl-dev 
sudo apt-get install -y libcurl4-gnutls-dev libexpat1-dev gettext unzip curl

#Updating repository
header_mensagem "Updating repository"
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

# Update system
header_mensagem "Update system with apt-get update"
sudo apt-get update -qq

# Install nvm
header_mensagem "Instaling npm via nvm"
sudo curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | sudo bash


# Install development softwares
header_mensagem "Instaling development softwares: git, docker, docker.io " 
sudo apt-get install -y git docker.io

# Install node and npm
header_mensagem "Instaling npm via nvm"
chmod +x ~/.nvm/nvm.sh 
sudo ~/.nvm/nvm.sh install node
sudo ~/.nvm/nvm.sh use node

# Install npm global packages
header_mensagem "Install npm global packages : nodemon, mocha, chai"
sudo npm install -g nodemon mocha chai typescript

# Install vscode
header_mensagem "Install VSCode"
sudo apt-get install -y vim kdiff3 code  # or code-insiders

# Symlink to dotfiles
header_mensagem "Symlink to dotfiles"
rm ~/.aliases
rm ~/.functions
cp -R ./.dotfiles/ ~/.dotfiles/ 
ln -sv ~/.dotfiles/.aliases ~
ln -sv ~/.dotfiles/.functions ~

header_mensagem "Done"

