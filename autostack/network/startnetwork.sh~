#!/bin/bash

rm -rf /etc/resolv.conf
cp ~/autostack/common/resolv.conf /etc/


sudo apt-get update && sudo apt-get update --fix-missing && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y
#sudo apt-get install openssh-server -y
sudo apt-get install sshpass -y

apt-get install ubuntu-cloud-keyring
echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu" \ "trusty-updates/juno main" > /etc/apt/sources.list.d/cloudarchive-juno.list

sudo apt-get update && sudo apt-get update --fix-missing && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y

#rm -rf  /etc/network/interfaces
#cp ~/autostack/controller/interfaces /etc/network/
#ifconfig p1p2 up
#ifconfig p1p1 up


#reboot



chmod u+x ~/autostack/network/networkntp.sh
chmod u+x ~/autostack/network/networknetworksecond.sh
chmod u+x ~/autostack/compute/networknetwork.sh

exit
