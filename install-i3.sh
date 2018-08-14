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

header_mensagem "Dependencies"
apt-get install -y cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config python-xcbgen xcb-proto libxcb-xrm-dev i3-wm libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev

header_mensagem "Installing and configuring i3"
apt-get install -y i3 feh arandr wicd-gtk rofi compton i3blocks i3lock-fancy htop

header_mensagem "Installing polybar"
git clone https://github.com/jaagr/polybar.git
cd polybar && ./build.sh


header_mensagem "Coping config files"
cp -r ./.config ~/
chmod +x $HOME/.config/polybar/launch.sh