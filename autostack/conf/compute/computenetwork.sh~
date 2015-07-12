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

sudo rm -rf /etc/sysctl.conf || check=false
sudo cp ~/pullstack/autostack/compute/sysctl.conf /etc/ || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi
if [ "$check" = true ] ; then
((linenumber=linenumber+1))

sudo sysctl -p || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 2
fi
if [ "$check" = true ] ; then
((linenumber=linenumber+1))

sudo apt-get install neutron-plugin-ml2 neutron-plugin-openvswitch-agent -y || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 3
fi
if [ "$check" = true ] ; then
((linenumber=linenumber+1))

sudo rm -rf /etc/neutron/neutron.conf || check=false
sudo cp ~/pullstack/autostack/compute/neutron.conf /etc/neutron/ || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 4
fi
if [ "$check" = true ] ; then
((linenumber=linenumber+1))

sudo rm -rf /etc/neutron/plugins/ml2/ml2_conf.ini || check=false
sudo cp ~/pullstack/autostack/compute/ml2_conf.ini /etc/neutron/plugins/ml2/ || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 5
fi
if [ "$check" = true ] ; then
((linenumber=linenumber+1))

sudo service openvswitch-switch restart || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 6
fi
if [ "$check" = true ] ; then
((linenumber=linenumber+1))

sudo rm -rf /etc/nova/nova.conf || check=false
sudo cp ~/pullstack/autostack/compute/computnetwork/nova.conf /etc/nova/ || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 7
fi
if [ "$check" = true ] ; then
((linenumber=linenumber+1))

sudo service nova-compute restart || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 8
fi
if [ "$check" = true ] ; then
((linenumber=linenumber+1))

sudo service neutron-plugin-openvswitch-agent restart || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 9
fi


echo *************** RETURNING FROM COMPUTE NODE ***************

exit



