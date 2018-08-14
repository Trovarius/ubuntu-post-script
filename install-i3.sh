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

header_mensagem "Installing and configuring i3"
apt-get install -y i3 feh arandr wicd-gtk rofi compton i3blocks i3lock-fancy htop

header_mensagem "Coping config files"
cp -r ./.config ~/
