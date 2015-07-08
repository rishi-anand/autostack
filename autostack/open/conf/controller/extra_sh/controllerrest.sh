#!/bin/bash

linenumber=0
check=true
filename=`basename "$0"`


if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo rm -rf /etc/neutron/neutron.conf || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 70
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo cp ~/autostack/controller/neutron.conf /etc/neutron/ || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 71
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo rm -rf /etc/neutron/plugins/ml2/ml2_conf.ini || check=false


echo -------------------$filename line no : $linenumber------------------------
#line no 72
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

cp ~/autostack/controller/ml2_conf.ini /etc/neutron/plugins/ml2/

echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))



rm -rf /etc/nova/nova.conf

echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


cp ~/autostack/controller/network_nova/nova.conf /etc/nova/



echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))



su -s /bin/sh -c "neutron-db-manage --config-file /etc/neutron/neutron.conf \ --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade juno" neutron

echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))




service nova-api restart
service nova-scheduler restart
service nova-conductor restart

echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


service neutron-server restart

echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


cd ~

source admin-openrc.sh

echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


neutron ext-list




echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))



sshpass -p welcome ssh -o StrictHostKeyChecking=no cliqr@192.168.4.202 "sudo -u root  ~/autostack/network/networknetwork.sh"

echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


service nova-api restart

echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sshpass -p welcome ssh -o StrictHostKeyChecking=no cliqr@192.168.4.202 "sudo -u root  ~/autostack/network/networknetworksecond.sh"

echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


 source admin-openrc.sh

neutron agent-list

echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sshpass -p welcome ssh -o StrictHostKeyChecking=no cliqr@192.168.4.204 "sudo -u root  ~/autostack/compute/computenetwork.sh"



echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))







source admin-openrc.sh


neutron agent-list


echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))





cp ~/autostack/controller/network_nova/nova.conf /etc/nova/

echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


echo --------------------------External Network--------------------

source admin-openrc.sh

neutron net-create ext-net --router:external True \
  --provider:physical_network external --provider:network_type flat

echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


neutron subnet-create ext-net --name ext-subnet \
  --allocation-pool start=192.168.4.210,end=192.168.4.225 \
  --disable-dhcp --gateway 192.168.4.1 192.168.4.0/24


echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


source demo-openrc.sh

neutron subnet-create demo-net --name demo-subnet \
  --gateway 10.25.0.1 10.25.0.0/24

echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


neutron router-create demo-router

echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


neutron router-interface-add demo-router demo-subnet

echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


neutron router-gateway-set demo-router ext-net


echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


apt-get install openstack-dashboard apache2 libapache2-mod-wsgi memcached python-memcache -y

echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


rm -rf /etc/openstack-dashboard/local_settings.py

echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


cp ~/autostack/controller/local_settings.py /etc/openstack-dashboard/

echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


service apache2 restart
service memcached restart



echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

cp ~/autostack/controller/network_nova/nova.conf /etc/nova/


echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi


