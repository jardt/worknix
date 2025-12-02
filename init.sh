#!/bin/bash

sudo apt update
sudo apt upgrade
sudo apt install vim swaylock zsh curl cmake pgk-config

chsh -s /bin/zsh

sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon


sudo sh -c "echo 'experimental-features = nix-command flakes' >> ~/.config/"


# wlroots
sudo apt update
sudo apt install build-essential git python3-pip
sudo apt install libwayland-dev libxkbcommon-dev libdrm-dev libinput-dev \
  libpixman-1-dev libgbm-dev libegl-dev libgles2-mesa-dev libglvnd-dev \
  libliftoff-dev libdisplay-info-dev libseat-dev libsystemd-dev \
  libxcb-composite0-dev libxcb-dri3-dev libxcb-ewmh-dev libxcb-icccm4-dev \
  libxcb-image0-dev libxcb-present-dev libxcb-render-util0-dev \
  libxcb-render0-dev libxcb-res0-dev libxcb-shm0-dev libxcb-xfixes0-dev \
  libxcb-xinput-dev libxcb1-dev meson pkgconf wayland-protocols

#in hm repo folder nix run home-manager/master -- init --switch

# sudo apt install build-essential
# sudo apt install git
# sudo apt install python3-pip
#
# pip3 install --user meson==0.55.3
#
# git clone -b 0.19.2 https://gitlab.freedesktop.org/wlroots/wlroots.git
# cd wlroots
# meson build -Dprefix=/usr
# sudo ninja -C build install
#
# cd
#
# git clone -b 0.4.1 https://github.com/wlrfx/scenefx.git
# cd scenefx
# meson build -Dprefix=/usr
# sudo ninja -C build install
#
# cd
#
# git clone https://github.com/DreamMaoMao/mangowc.git
# cd mangowc
# meson build -Dprefix=/usr
# sudo ninja -C build install
