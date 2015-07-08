
#!/bin/bash

linenumber=92
check=true
filename=`basename "$0"`
today=`date +%Y-%m-%d.%H:%M:%S`

exec 2> >(tee "Error_.$filename._.$today.err")
exec > >(tee "Log_.$filename._.$today.log")



if [ "$check" = true ] ; then
((linenumber=linenumber+1))

neutron subnet-create ext-net --name ext-subnet \
  --allocation-pool start=192.168.4.210,end=192.168.4.225 \
  --disable-dhcp --gateway 192.168.4.1 192.168.4.0/24  || check=false


echo -------------------$filename line no : $linenumber------------------------
#line no 93---------+--------------------------------------+
-------------------eight.sh
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

exit



