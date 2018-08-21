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
sudo apt-get install -y libcurl4-gnutls-dev libexpat1-dev gettext unzip curl zsh feh htop rofi

#Updating repository
header_mensagem "Updating repository"
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

# Update system
header_mensagem "Update system with apt-get update"
sudo apt-get update -qq

# Install development softwares
header_mensagem "Instaling development softwares: git, docker, docker.io " 
sudo apt-get install -y git docker.io
curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose


echo -e "Por favor entrar com seu e-mail para configuração do git:"
read  git_email

echo -e "Por favor entrar com seu usuário para configuração do git:"
read  git_usuario

git config --global user.email "$git_email"
git config --global user.name "$git_usuario"


# Install vscode
header_mensagem "Install VSCode"
sudo apt-get install -y vim kdiff3 code  # or code-insiders

# Install vscode plugin
code --install-extension christian-kohler.npm-intellisense
code --install-extension christian-kohler.path-intellisense
code --install-extension DavidAnson.vscode-markdownlint
code --install-extension dbaeumer.vscode-eslint
code --install-extension eg2.tslint
code --install-extension eg2.vscode-npm-script
code --install-extension HookyQR.beautify
code --install-extension humao.rest-client
code --install-extension jasonnutter.search-node-modules
code --install-extension ms-vsliveshare.vsliveshare
code --install-extension msjsdiag.debugger-for-chrome
code --install-extension PeterJausovec.vscode-docker
code --install-extension ritwickdey.LiveServer
code --install-extension waderyan.nodejs-extension-pack
code --install-extension xabikos.JavaScriptSnippets
code --install-extension yzhang.markdown-all-in-one

header_mensagem "INstall OhMyZsh"
rm -rf ~/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install nvm
header_mensagem "Instaling npm via nvm"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | sudo bash

# Symlink to dotfiles
header_mensagem "Coping config files"
rm -rf ~/.dotfiles
cp -arf ./ ~/.

echo "if [ -f ~/.dotfiles/aliases ]; then
    . ~/.dotfiles/aliases
fi" >> ~/.bashrc

echo "if [ -f ~/.dotfiles/functions ]; then
    . ~/.dotfiles/functions
fi" >> ~/.bashrc

echo "exec zsh" >> ~/.bashrc
header_mensagem "Creating workspace"
mkdir ~/workspace

header_mensagem "Transparency on terminal"
gconftool-2 -s '/apps/metacity/general/compositing_manager' --type bool true


header_mensagem "Done"

source ~/.bashrc