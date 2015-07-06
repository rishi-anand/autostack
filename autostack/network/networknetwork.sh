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

echo ----- Network Configuration of Network Node ------
sudo cp ~/autostack/autostack/common/resolv.conf /etc/ || check=false

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


sudo apt-get install ubuntu-cloud-keyring || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 3
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

echo ---- adding juno repository -----
sudo echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu" \ "trusty-updates/juno main" > /etc/apt/sources.list.d/cloudarchive-juno.list || check=false


echo -------------------$filename line no : $linenumber------------------------
#line no 4
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

echo ----- Updating and Upgrading -----
sudo apt-get update && sudo apt-get update --fix-missing && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y || check=false


echo -------------------$filename line no : $linenumber------------------------
#line no 5
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

sudo rm -rf  /etc/sysctl.conf || check=false
sudo cp ~/autostack/autostack/network/sysctl.conf /etc/ || check=false


echo -------------------$filename line no : $linenumber------------------------
#line no 6
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo sysctl -p || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 7
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo apt-get install neutron-plugin-ml2 neutron-plugin-openvswitch-agent \
  neutron-l3-agent neutron-dhcp-agent -y || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 8
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

sudo rm -rf  /etc/neutron/neutron.conf || check=false
sudo cp ~/autostack/autostack/network/neutron.conf /etc/neutron/ || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 9
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))
sudo rm -rf  /etc/neutron/plugins/ml2/ml2_conf.ini || check=false
sudo cp ~/autostack/autostack/network/ml2_conf.ini /etc/neutron/plugins/ml2/ || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 10
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo rm -rf /etc/neutron/l3_agent.ini || check=false
sudo cp ~/autostack/autostack/network/l3_agent.ini /etc/neutron/ || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 11
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo rm -rf /etc/neutron/dhcp_agent.ini || check=false
sudo cp ~/autostack/autostack/network/dhcp_agent.ini /etc/neutron/ || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 12
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo rm -rf /etc/neutron/dnsmasq-neutron.conf || check=false
sudo cp ~/autostack/autostack/network/dnsmasq-neutron.conf /etc/neutron/ || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 13
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo pkill dnsmasq || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 14
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo rm -rf /etc/neutron/metadata_agent.ini || check=false
sudo cp ~/autostack/autostack/network/metadata_agent.ini /etc/neutron/ || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 15
fi

echo *************** RETURNING FROM NETWORK NODE ***************

exit
