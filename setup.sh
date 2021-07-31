#!/bin/sh
. /etc/os-release

if [ $ID = "ubuntu" ] ; then
    sudo apt update -y
    sudo apt purge show-motd update-motd snapd openssh-client openssh-server cloud-init git -y
    sudo apt autoremove --purge -y
    sudo rm -rf /etc/cloud /var/lib/cloud
    sudo add-apt-repository ppa:git-core/ppa -y

    sudo apt upgrade -y
    sudo apt autoremove --purge -y
    sudo apt install curl wget rsync vim unzip openssh-client git man-db -y
    sudo apt autoremove --purge -y
    sudo apt clean all

    sudo apt update;
    cp ./.bashrc ~/.bashrc
fi

if [ $ID = "alpine" ] ; then
    sed -i -e 's/v[0-9]*\.[0-9]*/edge/g' /etc/apk/repositories
    apk -U upgrade
    apk add curl git sudo git unzip
    cp ./.bashrc ~/.profile
fi

## Personal workspace setup
git config --global init.defaultBranch main
git config --global user.name "Ranvir Singh"
git config --global user.email "sranvir155@gmail.com"

### Adding SSH keys and SSH client config from hard drive
umask 077
if [ ! -d ~/.ssh ] ; then
  cp -r /mnt/e/.ssh $HOME/
  chmod 600 $HOME/.ssh/config
  chmod 400 ~/.ssh/id*
fi

## Adding VS Code and Explorer to PATH
sudo ln -s /mnt/c/Users/r/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code /usr/local/bin/code
sudo ln -s /mnt/c/Windows/explorer.exe /usr/local/bin/explorer.exe
sudo cat ./wsl.conf > /etc/wsl.conf
sudo rm -r /etc/resolv.conf /run/resolvconf/
sudo cat ./resolv.conf > /etc/resolv.conf

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "$HOME/awscliv2.zip"
sudo fstrim /
exit 0
