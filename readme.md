# basic

sudo adduser tempadmin

sudo usermod -aG sudo tempadmin

sudo mv /home/oldusername /home/newusername

sudo usermod -l newusername oldusername

sudo usermod -d /home/newusername -m newusername

sudo userdel -r tempadmin

bash init.sh

reboot

# install nix

experimental-features = nix-command flakes > nix.conf

access-token github > nix.conf

ssh-keys github

nix run home-manager/master -- init --switch

xdg-portal-service fails???
