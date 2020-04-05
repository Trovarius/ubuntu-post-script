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

header_mensagem "Ubuntu post-install script fo WSL"

# Update system
header_mensagem "Update system with apt update"
sudo apt update -qq

# Install base software
header_mensagem "Instaling base libraries"
sudo apt install -y build-essential libssl-dev git docker.io
sudo apt install -y libcurl4-gnutls-dev libexpat1-dev gettext unzip curl zsh htop bat vim


# Install development softwares 
curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose


echo -e "Por favor entrar com seu e-mail para configuração do git:"
read  git_email

echo -e "Por favor entrar com seu usuário para configuração do git:"
read  git_usuario

git config --global user.email "$git_email"
git config --global user.name "$git_usuario"


header_mensagem "INstall OhMyZsh"
rm -rf ~/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install nvm
header_mensagem "Instaling npm via nvm"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash


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


header_mensagem "Fianlizado - o seu terminal irá reiniciar em 3 segundos com as novas configurações."

sleep 3s

source ~/.bashrc