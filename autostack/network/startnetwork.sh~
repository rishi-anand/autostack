#!/bin/bash

echo ************* INSIDE NETWORK NODE **************
echo ----******--Welcome to network node--******----

linenumber=0
check=true
filename=`basename "$0"`
today=`date +%Y-%m-%d.%H:%M:%S`

exec 2> >(tee "Error_.$filename._.$today.err")
exec > >(tee "Log_.$filename._.$today.log")


if [ "$check" = true ] ; then
((linenumber=linenumber+1))

sudo rm -rf /etc/resolv.conf || check=false
sudo cp ~/pullstack/autostack/common/resolv.conf /etc/ || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

sudo apt-get update || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 2
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

echo -------- installing openssh server ----------
sudo apt-get install openssh-server -y || check=false
echo -------- installing ssh-pass -----------
sudo apt-get install sshpass -y || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 3
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo apt-get install ubuntu-cloud-keyring || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 4
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

sudo echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu" \ "trusty-updates/juno main" > /etc/apt/sources.list.d/cloudarchive-juno.list || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 5
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo apt-get update && sudo apt-get update --fix-missing && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 6
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


#sudo rm -rf  /etc/network/interfaces || check=false
#sudo cp ~/pullstack/autostack/controller/interfaces /etc/network/ || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 7
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


#sudo ifconfig p1p2 up || check=false
#sudo ifconfig p1p1 up || check=false


echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


chown root ~/pullstack/autostack/network/networkntp.sh || echo "Unable to set Permission"
chmod 700 ~/pullstack/autostack/network/networkntp.sh || echo "Unable to set Permission"
chown root ~/pullstack/autostack/network/networknetworksecond.sh || echo "Unable to set Permission"
chmod 700 ~/pullstack/autostack/network/networknetworksecond.sh || echo "Unable to set Permission"
chown root ~/pullstack/autostack/network/networknetwork.sh || echo "Unable to set Permission"
chmod 700 ~/pullstack/autostack/network/networknetwork.sh || echo "Unable to set Permission"
chmod u+x ~/pullstack/autostack/network/networkntp.sh || echo "Unable to set Permission"
chmod u+x ~/pullstack/autostack/network/networknetworksecond.sh || echo "Unable to set Permission"
chmod u+x ~/pullstack/autostack/compute/networknetwork.sh || echo "Unable to set Permission"

echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi
echo *************** RETURNING FROM NETWORK NODE ***************
#reboot


exit
