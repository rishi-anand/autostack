#!/bin/bash


echo --------- NOW WORKING IN COMPUTE NODE ------------------------
rm -rf /etc/resolv.conf
cp ~/autostack/common/resolv.conf /etc/

sudo apt-get update && sudo apt-get update --fix-missing && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y
apt-get install ubuntu-cloud-keyring
echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu" \ "trusty-updates/juno main" > /etc/apt/sources.list.d/cloudarchive-juno.list

sudo apt-get update && sudo apt-get update --fix-missing && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y

echo --------- NOW WORKING IN COMPUTE NODE ------------------------
apt-get install nova-compute sysfsutils -y
rm -rf /etc/nova/nova.conf
cp ~/autostack/compute/computenetwork/nova.conf /etc/nova/




egrep -c '(vmx|svm)' /proc/cpuinfo

service nova-compute restart
rm -f /var/lib/nova/nova.sqlite





