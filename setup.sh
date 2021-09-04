#!/bin/sh
. /etc/os-release

if [ $ID = "ubuntu" ] ; then
    apt update -y
    apt purge show-motd update-motd snapd openssh-client openssh-server cloud-init git -y
    apt autoremove --purge -y
    rm -rf /etc/cloud /var/lib/cloud
    add-apt-repository ppa:git-core/ppa -y

    apt upgrade -y
    apt autoremove --purge -y
    apt install curl wget rsync vim unzip openssh-client git man-db -y
    apt autoremove --purge -y
    apt clean all

    apt update;
    cp ./.bashrc ~/.bashrc
fi

if [ $ID = "alpine" ] ; then
    sed -i -e 's/v[0-9]*\.[0-9]*/edge/g' /etc/apk/repositories
    apk -U upgrade
    apk add curl git
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
ln -s /mnt/c/Users/r/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code /usr/local/bin/code
ln -s /mnt/c/Windows/explorer.exe /usr/local/bin/explorer.exe
cat ./wsl.conf > /etc/wsl.conf
rm -r /etc/resolv.conf /run/resolvconf/
cat ./resolv.conf > /etc/resolv.conf

fstrim /
exit 0
