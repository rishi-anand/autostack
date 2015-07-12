#!/bin/bash


echo ************* INSIDE COMPUTE NODE **************
echo ----******--Welcome to Compute Node--******----

linenumber=0
check=true
filename=`basename "$0"`
today=`date +%Y-%m-%d.%H:%M:%S`

exec 2> >(tee "Error_.$filename._.$today.err")
exec > >(tee "Log_.$filename._.$today.log")


if [ "$check" = true ] ; then
((linenumber=linenumber+1))

sudo rm -rf /etc/resolv.conf || check=false
sudo cp ~/pullstack/autostack/common/resolv.conf /etc || check=false
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


sudo echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu" \ "trusty-updates/juno main" > /etc/apt/sources.list.d/cloudarchive-juno.list || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 4
fi
if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo apt-get update && sudo apt-get update --fix-missing && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 5
fi
if [ "$check" = true ] ; then
((linenumber=linenumber+1))

sudo apt-get install nova-compute sysfsutils -y || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 6
fi
if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo rm -rf /etc/nova/nova.conf || check=false
sudo cp ~/pullstack/autostack/compute/computenetwork/nova.conf /etc/nova/ || check=false



echo -------------------$filename line no : $linenumber------------------------
#line no 7
fi
if [ "$check" = true ] ; then
((linenumber=linenumber+1))


echo  --Below if- value is greater than 0 then- your node supports hardware acceleration of virtual machines--
egrep -c '(vmx|svm)' /proc/cpuinfo

echo -------------------$filename line no : $linenumber------------------------
#line no 8
fi
if [ "$check" = true ] ; then
((linenumber=linenumber+1))
sudo service nova-compute restart || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 9
fi
if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo rm -f /var/lib/nova/nova.sqlite || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 10
fi

echo *************** RETURNING FROM COMPUTE NODE ***************
exit


