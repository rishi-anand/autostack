#!/bin/bash

linenumber=0
check=true
filename=`basename "$0"`


if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo rm -rf /etc/neutron/neutron.conf || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 72
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo cp ~/pullstack/autostack/controller/neutron.conf /etc/neutron/ || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 73
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo rm -rf /etc/neutron/plugins/ml2/ml2_conf.ini || check=false


echo -------------------$filename line no : $linenumber------------------------
#line no 74
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

sudo cp ~/pullstack/autostack/controller/ml2_conf.ini /etc/neutron/plugins/ml2/ || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 75
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))



sudo rm -rf /etc/nova/nova.conf || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 76
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo cp ~/pullstack/autostack/controller/network_nova/nova.conf /etc/nova/ || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 77
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))



sudo su -s /bin/sh -c "neutron-db-manage --config-file /etc/neutron/neutron.conf \ --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade juno" neutron || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 78
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

sudo service nova-api restart || check=false
sudo service nova-scheduler restart || check=false
sudo service nova-conductor restart || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 79
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

sudo service neutron-server restart || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 80
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))
echo ------%%%%%%%%%%%%%%%%%%------  "Verifying Operation - NETWORK [Controller] SERVICE" ------%%%%%%%%%%%%%%%%%%------

cd ~/ || check=false

source admin-openrc.sh || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 81
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


neutron ext-list || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 82
fi
######### installing network on network node ##########
if [ "$check" = true ] ; then
((linenumber=linenumber+1))

echo ---======---  Installing NETWORK Services - Network Node ---======---
echo --- Going To Network Node ---
sshpass -p welcome ssh -o StrictHostKeyChecking=no cliqr@192.168.4.202 "sudo -u root  ~/pullstack/autostack/network/networknetwork.sh" || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 83
fi


if [ "$check" = true ] ; then
((linenumber=linenumber+1))
sudo rm -rf /etc/nova/nova.conf || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 84
fi
if [ "$check" = true ] ; then
((linenumber=linenumber+1))
sudo cp ~/pullstack/autostack/controller/network_nova/netwotk_network_nova/nova.conf /etc/nova/ || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 85
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo service nova-api restart || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 86
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sshpass -p welcome ssh -o StrictHostKeyChecking=no cliqr@192.168.4.202 "sudo -u root  ~/pullstack/autostack/network/networknetworksecond.sh" || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 87
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

echo ------%%%%%%%%%%%%%%%%%%------  "Verifying Operation - NETWORK [Network] SERVICE" ------%%%%%%%%%%%%%%%%%%------
 source admin-openrc.sh || check=false

neutron agent-list || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 88
fi
################ installing network on compute node ################

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

echo ---======---  Installing NETWORK Services - Compute Node ---======---
echo --- Going To Compute Node ---
sshpass -p welcome ssh -o StrictHostKeyChecking=no cliqr@192.168.4.204 "sudo -u root  ~/pullstack/autostack/compute/computenetwork.sh" || check=false



echo -------------------$filename line no : $linenumber------------------------
#line no 89
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))
echo ------%%%%%%%%%%%%%%%%%%------  "Verifying Operation - NETWORK [Compute] SERVICE" ------%%%%%%%%%%%%%%%%%%------
source admin-openrc.sh || check=false
neutron agent-list || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 90
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

source admin-openrc.sh || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 91
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

echo ------%%%%%%%%%%%%%%%%%%------  "Installing External - NETWORK SERVICE" ------%%%%%%%%%%%%%%%%%%------
source admin-openrc.sh || check=false

neutron net-create ext-net --router:external True \
  --provider:physical_network external --provider:network_type flat || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 92
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


neutron subnet-create ext-net --name ext-subnet \
  --allocation-pool start=192.168.4.210,end=192.168.4.225 \
  --disable-dhcp --gateway 192.168.4.1 192.168.4.0/24  || check=false


echo -------------------$filename line no : $linenumber------------------------
#line no 93
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

echo ------%%%%%%%%%%%%%%%%%%------  "Installing Tenant - NETWORK SERVICE" ------%%%%%%%%%%%%%%%%%%------
source demo-openrc.sh || check=false
neutron net-create demo-net || check=false
#neutron subnet-create demo-net --name demo-subnet \
 # --gateway 10.25.0.1 10.25.0.0/24 || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 94
fi
if [ "$check" = true ] ; then
((linenumber=linenumber+1))


neutron subnet-create demo-net --name demo-subnet \
  --gateway 10.25.0.1 10.25.0.0/24 || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 95
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

source demo-openrc.sh || check=false
neutron router-create demo-router || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 96
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


neutron router-interface-add demo-router demo-subnet || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 97
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


neutron router-gateway-set demo-router ext-net || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 98
fi


if [ "$check" = true ] ; then
((linenumber=linenumber+1))
echo ------%%%%%%%%%%%%%%%%%%------  "Verifying Operation - NETWORK [Compute] SERVICE" ------%%%%%%%%%%%%%%%%%%------
echo -- Nothing Added Here, So, dont worry --

echo -------------------$filename line no : $linenumber------------------------
echo ---- original line no 99---
#line no 99
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo apt-get install openstack-dashboard apache2 libapache2-mod-wsgi memcached python-memcache -y || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 100
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo rm -rf /etc/openstack-dashboard/local_settings.py || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 101
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo cp ~/pullstack/autostack/controller/local_settings.py /etc/openstack-dashboard/ || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 102
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))
sudo service apache2 restart || check=false
sudo service memcached restart || check=false
echo -------------------$filename line no : $linenumber------------------------
echo --- original line no 103 ---
echo ----################## DASHBOARD INSTALLED -#################-----
#line no 103
fi

fi

exit



