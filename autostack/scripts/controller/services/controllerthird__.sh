#!/bin/bash

linenumber=0
check=true
filename=`basename "$0"`
today=`date +%Y-%m-%d.%H:%M:%S`

exec 2> >(tee "Error_.$filename._.$today.err")
exec > >(tee "Log_.$filename._.$today.log")





#-------------------- Check if Internet is working if not working then updating Nameserver [STARTS]-----------------------------------
internet_working=true
is_resolv=true
ping -c 3 www.google.com || internet_working=false
if [ "$internet_working" = false ] ; then
    
    name_server=$(cat /etc/resolv.conf | grep $NAMESERVER_IP )
        if [ -z "$name_server" ]
        then
             sudo echo nameserver $NAMESERVER_IP >> /etc/resolv.conf || is_resolv=false
             if [ "$is_resolv" = false ] ; then
                      if [ -s ~/pullstack/autostack/conf/common/resolv.conf ]; then
                              
                               sudo replace "NAMESERVER_IP" $NAMESERVER_IP -- ~/pullstack/autostack/conf/common/*
                               updatednameserverip=$(cat ~/pullstack/autostack/conf/common/resolv.conf | grep $NAMESERVER_IP)
                               if [ ! -z "$updatednameserverip" ]; then
                               sudo rm -rf /etc/resolv.conf
                               sudo cp ~/pullstack/autostack/conf/common/resolv.conf /etc/
                                                      else
                                                      echo ---------------------------------------------------------
                                                      echo \|   Manually Add Nameserver IP in- /etc/resolv.conf file- \|
                                                      echo ---------------------------------------------------------

                               fi
                       else
echo ---------------------------------------------------------
echo \|   Manually Add Nameserver IP in- /etc/resolv.conf file- \|
echo ---------------------------------------------------------


                      fi

             fi

        fi
else
echo --------------------------------
echo \|   Internet is working properly \|
echo --------------------------------
fi
#-------------------- Check if Internet is working if not working then updating Nameserver [ENDS] -------------------------------------------




if [ "$check" = true ] ; then
((linenumber=linenumber+1))
sudo rm -rf /etc/keystone/keystone.conf || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

sudo cp ~/pullstack/autostack/controller/keystone.conf /etc/keystone/ || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 2
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))
sudo su -s /bin/sh -c "keystone-manage db_sync" keystone || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 3
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

sudo service keystone restart || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 4
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

rm -rf /var/lib/keystone/keystone.db || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 5
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


(crontab -l -u keystone 2>&1 | grep -q token_flush) || \
  echo '@hourly /usr/bin/keystone-manage token_flush >/var/log/keystone/keystone-tokenflush.log 2>&1' \
  >> /var/spool/cron/crontabs/keystone || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 6
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


echo --- !!!!!  Enter previously copied ADMIN TOKEN  !!!!! -----
read ADMIN_TOKEN
export OS_SERVICE_TOKEN=$ADMIN_TOKEN || check=false
export OS_SERVICE_ENDPOINT=http://$CONTROLLER_NODE_HOSTNAME:35357/v2.0 || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 7
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

keystone tenant-create --name admin --description "Admin Tenant" || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 8
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

echo ---- ??? Enter Admin Password ??? -----
read ADMIN_PASS
echo ---- ??? Enter Admin Email Id ??? -----
read EMAIL_ADDRESS

keystone user-create --name admin --pass $ADMIN_PASS --email $EMAIL_ADDRESS || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 9
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

keystone role-create --name admin || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 10
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

keystone user-role-add --user admin --tenant admin --role admin || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 11
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

keystone tenant-create --name demo --description "Demo Tenant" || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 12
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

keystone user-create --name demo --tenant demo --pass $DEMO_PASS --email $EMAIL_ADDRESS || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 13
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

keystone tenant-create --name service --description "Service Tenant" || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 14
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

keystone service-create --name keystone --type identity \
  --description "OpenStack Identity" || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 15
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

export OS_SERVICE_TOKEN=$ADMIN_TOKEN
export OS_SERVICE_ENDPOINT=http://$CONTROLLER_NODE_HOSTNAME:35357/v2.0

keystone endpoint-create \
  --service-id $(keystone service-list | awk '/ identity / {print $2}') \
  --publicurl http://$CONTROLLER_NODE_HOSTNAME:5000/v2.0 \
  --internalurl http://$CONTROLLER_NODE_HOSTNAME:5000/v2.0 \ source admin-openrc.sh
  --adminurl http://$CONTROLLER_NODE_HOSTNAME:35357/v2.0 \
  --region regionOne || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 16
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


echo ------%%%%%%%%%%%%%%%%%%------  "Verifying Operation - IDENTITY SERVICE" ------%%%%%%%%%%%%%%%%%%------

unset OS_SERVICE_TOKEN OS_SERVICE_ENDPOINT || check=false

keystone --os-tenant-name admin --os-username admin --os-password welcome \
  --os-auth-url http://$CONTROLLER_NODE_HOSTNAME:35357/v2.0 token-get || check=false


echo -------------------$filename line no : $linenumber------------------------
#line no 17
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))



keystone --os-tenant-name admin --os-username admin --os-password welcome \
  --os-auth-url http://$CONTROLLER_NODE_HOSTNAME:35357/v2.0 tenant-list || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 18
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

keystone --os-tenant-name admin --os-username admin --os-password $ADMIN_PASS \
  --os-auth-url http://$CONTROLLER_NODE_HOSTNAME:35357/v2.0 user-list || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 19
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


keystone --os-tenant-name admin --os-username admin --os-password $ADMIN_PASS \
  --os-auth-url http://$CONTROLLER_NODE_HOSTNAME:35357/v2.0 role-list || check=false


echo -------------------$filename line no : $linenumber------------------------
#line no 20
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


keystone --os-tenant-name demo --os-username demo --os-password welcome \
  --os-auth-url http://$CONTROLLER_NODE_HOSTNAME:35357/v2.0 token-get || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 21
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

echo ---- If output is [
You are not authorized to perform the requested action, admin_required. (HTTP 403)]---- it is successful----
keystone --os-tenant-name demo --os-username demo --os-password welcome \
  --os-auth-url http://$CONTROLLER_NODE_HOSTNAME:35357/v2.0 user-list || check=false


echo -------------------$filename line no : $linenumber------------------------
#line no 22
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

sudo cp ~/pullstack/autostack/controller/admin-openrc.sh ~/ || check=false
sudo cp ~/pullstack/autostack/controller/demo-openrc.sh ~/ || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 23
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


source admin-openrc.sh || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 24
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

echo ---=== Copy These Lines and paste as it is by editing password ===---

echo ====== CREATE DATABASE glance ======
echo ====== GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'localhost' \ IDENTIFIED BY 'GLANCE_DBPASS' ======
echo ====== GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'%' \ IDENTIFIED BY 'GLANCE_DBPASS'======
echo ====== exit ======

mysql -u root -p || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 25
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))



cd ~/ || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 26
fi
if [ "$check" = true ] ; then
((linenumber=linenumber+1))
source admin-openrc.sh || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 27
fi
if [ "$check" = true ] ; then
((linenumber=linenumber+1))
keystone user-create --name glance --pass $ADMIN_PASS || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 28
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))
keystone user-role-add --user glance --tenant service --role admin || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 29
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


keystone service-create --name glance --type image \ --description "OpenStack Image Service" || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 30
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


keystone endpoint-create \
  --service-id $(keystone service-list | awk '/ image / {print $2}') \
  --publicurl http://$CONTROLLER_NODE_HOSTNAME:9292 \
  --internalurl http://$CONTROLLER_NODE_HOSTNAME:9292 \
  --adminurl http://$CONTROLLER_NODE_HOSTNAME:9292 \
  --region regionOne || check=false


echo -------------------$filename line no : $linenumber------------------------
#line no 31
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo apt-get install glance python-glanceclient -y || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 32
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo rm -rf /etc/glance/glance-api.conf || check=false


echo -------------------$filename line no : $linenumber------------------------
#line no 33
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo cp ~/pullstack/autostack/controller/glance-api.conf /etc/glance/ || check=false


echo -------------------$filename line no : $linenumber------------------------
#line no 34
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo rm -rf /etc/glance/glance-registry.conf || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 35
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo cp ~/pullstack/autostack/controller/glance-registry.conf /etc/glance/ || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 36
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo su -s /bin/sh -c "glance-manage db_sync" glance || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 37
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo service glance-registry restart || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 38
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo service glance-api restart || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 39
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))
sudo rm -f /var/lib/glance/glance.sqlite || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 40
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))
echo ------%%%%%%%%%%%%%%%%%%------  "Verifying Operation - IMAGE SERVICE" ------%%%%%%%%%%%%%%%%%%------
cd ~/ || check=false
sudo mkdir /tmp/images || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 41
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


wget -P /tmp/images http://download.cirros-cloud.net/0.3.3/cirros-0.3.3-x86_64-disk.img || check=false


echo -------------------$filename line no : $linenumber------------------------
#line no 42
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


cd ~/ || check=false
source admin-openrc.sh || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 43
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


glance image-create --name "cirros-0.3.3-x86_64" --file /tmp/images/cirros-0.3.3-x86_64-disk.img \
  --disk-format qcow2 --container-format bare --is-public True --progress || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 44
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


glance image-list || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 45
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo rm -r /tmp/images || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 46
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


echo -#################  Installing COMPUTE Services  -###############

echo -------Copy These Lines and paste as it is by editing password.-------
echo ====== CREATE DATABASE nova ======
echo ====== GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'localhost' \ IDENTIFIED BY 'NOVA_DBPASS' ======
echo ====== GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'%' \ IDENTIFIED BY 'NOVA_DBPASS' ======
echo ====== exit ======

mysql -u root -p  || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 47
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


cd ~
source admin-openrc.sh || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 48
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


keystone user-create --name nova --pass $ADMIN_PASS || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 49
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


keystone user-role-add --user nova --tenant service --role admin || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 50
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


keystone service-create --name nova --type compute \
  --description "OpenStack Compute" || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 51
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

keystone endpoint-create \
  --service-id $(keystone service-list | awk '/ compute / {print $2}') \
  --publicurl http://$CONTROLLER_NODE_HOSTNAME:8774/v2/%\(tenant_id\)s \
  --internalurl http://$CONTROLLER_NODE_HOSTNAME:8774/v2/%\(tenant_id\)s \
  --adminurl http://$CONTROLLER_NODE_HOSTNAME:8774/v2/%\(tenant_id\)s \
  --region regionOne || check=false


echo -------------------$filename line no : $linenumber------------------------
#line no 52
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))



sudo apt-get install nova-api nova-cert nova-conductor nova-consoleauth \
  nova-novncproxy nova-scheduler python-novaclient -y || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 53
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo rm -rf /etc/nova/nova.conf || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 54
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo cp ~/pullstack/autostack/controller/nova.conf /etc/nova/ || check=false


echo -------------------$filename line no : $linenumber------------------------
#line no 55
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

echo @@@@@@  Populate the Compute database  @@@@@@
sudo su -s /bin/sh -c "nova-manage db sync" nova || check=false


echo -------------------$filename line no : $linenumber------------------------
#line no 56
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo service nova-api restart || check=false
sudo service nova-cert restart || check=false
sudo service nova-consoleauth restart || check=false
sudo service nova-scheduler restart || check=false
sudo service nova-conductor restart || check=false
sudo service nova-novncproxy restart || check=false


echo -------------------$filename line no : $linenumber------------------------
#line no 57
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


sudo rm -f /var/lib/nova/nova.sqlite || check=false


echo -------------------$filename line no : $linenumber------------------------
#line no 58
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

echo -----------------Going to COMPUTE NODE-------------------


sshpass -p welcome ssh -o StrictHostKeyChecking=no cliqr@192.168.4.204 "sudo -u root  ~/pullstack/autostack/compute/computenova.sh" || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 59
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


echo -----------------Back from COMPUTE NODE-------------------

echo ------%%%%%%%%%%%%%%%%%%------  "Verifying Operation - COMPUTE SERVICE" ------%%%%%%%%%%%%%%%%%%------
cd ~/ || check=false
source admin-openrc.sh || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 60
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


nova service-list || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 61
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


nova image-list || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 62
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


echo -#################  Installing NETWORK Services  -###############

echo ---======---  Installing NETWORK Services - Controller Node ---======---

echo ====== CREATE DATABASE neutron ======
echo ====== GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'localhost' \ IDENTIFIED BY 'NEUTRON_DBPASS' ======
echo ====== GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'%' \ IDENTIFIED BY 'NEUTRON_DBPASS' ======

echo ====== exit ======
#mysql -u root -p || check=false


echo -------------------$filename line no : $linenumber------------------------
#line no 63
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))



cd ~/ || check=false
source admin-openrc.sh || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 64
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))



keystone user-create --name neutron --pass welcome || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 65
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


keystone user-role-add --user neutron --tenant service --role admin || check=false


echo -------------------$filename line no : $linenumber------------------------
#line no 66
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


keystone service-create --name neutron --type network \
  --description "OpenStack Networking" || check=false


echo -------------------$filename line no : $linenumber------------------------
#line no 67
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

keystone endpoint-create \
  --service-id $(keystone service-list | awk '/ network / {print $2}') \
  --publicurl http://$CONTROLLER_NODE_HOSTNAME:9696 \
  --adminurl http://$CONTROLLER_NODE_HOSTNAME:9696 \
  --internalurl http://$CONTROLLER_NODE_HOSTNAME:9696 \
  --region regionOne || check=false



echo -------------------$filename line no : $linenumber------------------------
#line no 68
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))



sudo apt-get install neutron-server neutron-plugin-ml2 python-neutronclient -y || check=false


echo -------------------$filename line no : $linenumber------------------------
#line no 69
fi

####################   GET SERVICE ID  #########################

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


source admin-openrc.sh || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 70
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

keystone tenant-get service || check=false
source admin-openrc.sh
SERVICE_TENANT_ID=$(keystone tenant-get service|grep id| cut -d '|' -f 3) || check=false
echo SERVICE_TENANT_ID = $SERVICE_TENANT_ID
replace "SERVICE_TENANT_ID" $SERVICE_TENANT_ID -- ~/pullstack/autostack/conf/controller/neutron.conf || check=false

if [ "$check" = true ]; then
echo SERVICE_TENANT_ID is replaced -in -~/pullstack/autostack/conf/controller/neutron.conf
fi

echo -------------------$filename line no : $linenumber------------------------
#line no 71
fi


######################   SERVICE ID END  #######################

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

#sudo is true, i have checked it
sudo su -s /bin/sh -c "neutron-db-manage --config-file /etc/neutron/neutron.conf \
  --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade juno" neutron || check=false

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



