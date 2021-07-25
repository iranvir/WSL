#!/bin/sh
source /etc/os-release

if [ $ID = "ubuntu" ] ; then
    ## Ubuntu specific setup
    sudo apt update -y
    sudo apt purge show-motd update-motd snapd openssh-client openssh-server cloud-init git -y
    sudo apt autoremove --purge -y
    sudo rm -rf /etc/cloud /var/lib/cloud
    sudo add-apt-repository ppa:git-core/ppa -y

    sudo apt upgrade -y
    sudo apt autoremove --purge -y
    sudo apt install curl wget rsync vim openssh-client git man-db -y
    sudo apt autoremove --purge -y
    sudo apt clean all

    sudo apt update;
    ## Ubuntu specific setup ends here
fi

if [ $ID = "alpine" ] ; then
    ## Alpine specific setup
    sed -i -e 's/v[0-9]*\.[0-9]*/edge/g' /etc/apk/repositories
    sudo apk update -y
    sudo apk purge show-motd update-motd snapd openssh-client openssh-server cloud-init git -y
    ## Alpine specific setup ends here
fi

## Personal workspace setup
cp ./.bashrc ~/.bashrc
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

sudo sed -i 's/HashKnownHosts yes/HashKnownHosts no/' /etc/ssh/ssh_config
sudo sed -i 's/#   StrictHostKeyChecking ask/\ \ \ \ StrictHostKeyChecking no/' /etc/ssh/ssh_config
### End Of SSH client Setup

sudo fstrim /
exit 0
