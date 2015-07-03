#!/bin/bash


echo -----network configuration of network100---


cp ~/autostack/common/resolv.conf /etc/

sudo apt-get update && sudo apt-get update --fix-missing && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y
apt-get install ubuntu-cloud-keyring
echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu" \ "trusty-updates/juno main" > /etc/apt/sources.list.d/cloudarchive-juno.list

#sudo apt-get update && sudo apt-get update --fix-missing && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y

apt-get update && apt-get dist-upgrade


rm -rf  /etc/sysctl.conf
cp ~/autostack/network/sysctl.conf /etc/

sysctl -p

apt-get install neutron-plugin-ml2 neutron-plugin-openvswitch-agent \
  neutron-l3-agent neutron-dhcp-agent -y

rm -rf  /etc/neutron/neutron.conf
cp ~/autostack/network/neutron.conf /etc/neutron/

rm -rf  /etc/neutron/plugins/ml2/ml2_conf.ini
cp ~/autostack/network/ml2_conf.ini /etc/neutron/plugins/ml2/

rm -rf /etc/neutron/l3_agent.ini
cp ~/autostack/network/l3_agent.ini /etc/neutron/

rm -rf /etc/neutron/dhcp_agent.ini
cp ~/autostack/network/dhcp_agent.ini /etc/neutron/

rm -rf /etc/neutron/dnsmasq-neutron.conf
cp ~/autostack/network/dnsmasq-neutron.conf /etc/neutron/

pkill dnsmasq

rm -rf /etc/neutron/metadata_agent.ini
cp ~/autostack/network/metadata_agent.ini /etc/neutron/

echo ------exiting network node--------










