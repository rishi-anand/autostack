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

sudo service openvswitch-switch restart || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

sudo ovs-vsctl add-br br-ex || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 2
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

sudo ovs-vsctl add-port br-ex p2p1 || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 3
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo service neutron-plugin-openvswitch-agent restart || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 4
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))
sudo service neutron-l3-agent restart || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 5
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))
sudo service neutron-dhcp-agent restart || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 6
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))
sudo service neutron-metadata-agent restart || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 7
fi

echo *************** RETURNING FROM NETWORK NODE ***************

exit
