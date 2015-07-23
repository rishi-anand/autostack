#!/bin/bash

. ~/pullstack/autostack/autostack.properties

filename=`basename "$0"`
today=`date +%Y-%m-%d.%H:%M:%S`

exec 2> >(tee "Error_.$filename._.$today.err")
exec > >(tee "Log_.$filename._.$today.log")

echo -----------------############### NOW IN REPLACE CONTROLLER.SH FILE -###############-----------------

echo NAMESERVER_IP = $NAMESERVER_IP
echo CONTROLLER_NODE_HOSTNAME = $CONTROLLER_NODE_HOSTNAME
echo CONTROLLER_NODE_PUBLIC_IP = $CONTROLLER_NODE_PUBLIC_IP
echo CONTROLLER_NODE_PRIVATE_IP = $CONTROLLER_NODE_PRIVATE_IP

echo NETWORK_NODE_HOSTNAME = $NETWORK_NODE_HOSTNAME
echo NETWORK_NODE_PUBLIC_IP = $NETWORK_NODE_PUBLIC_IP
echo NETWORK_NODE_PRIVATE_IP = $NETWORK_NODE_PRIVATE_IP

echo COMPUTE_NODE_HOSTNAME = $COMPUTE_NODE_HOSTNAME
echo COMPUTE_NODE_PUBLIC_IP = $COMPUTE_NODE_PUBLIC_IP
echo COMPUTE_NODE_PRIVATE_IP = $COMPUTE_NODE_PRIVATE_IP

echo FLOATING_IP_START = $FLOATING_IP_START
echo FLOATING_IP_END = $FLOATING_IP_END
echo EXTERNAL_NETWORK_GATEWAY = $EXTERNAL_NETWORK_GATEWAY 
echo EXTERNAL_NETWORK_CIDR = $EXTERNAL_NETWORK_CIDR
echo TENANT_NETWORK_GATEWAY = $TENANT_NETWORK_GATEWAY
echo TENANT_NETWORK_CIDR = $TENANT_NETWORK_CIDR

echo NETWORK_PUBLIC_INTERFACE_NAME = $NETWORK_PUBLIC_INTERFACE_NAME
echo NETWORK_NETMASK_PUBLIC_INTERFACE = $NETWORK_NETMASK_PUBLIC_INTERFACE
echo NETWORK_NETWORK_PUBLIC_INTERFACE = $NETWORK_NETWORK_PUBLIC_INTERFACE
echo NETWORK_BROADCAST_PUBLIC_INTERFACE = $NETWORK_BROADCAST_PUBLIC_INTERFACE
echo NETWORK_GATEWAY_PUBLIC_INTERFACE = $NETWORK_GATEWAY_PUBLIC_INTERFACE

echo NETWORK_PRIVATE_INTERFACE_NAME = $NETWORK_PRIVATE_INTERFACE_NAME
echo NETWORK_NETMASK_PRIVATE_INTERFACE = $NETWORK_NETMASK_PRIVATE_INTERFACE
echo NETWORK_NETWORK_PRIVATE_INTERFACE = $NETWORK_NETWORK_PRIVATE_INTERFACE
echo NETWORK_BROADCAST_PRIVATE_INTERFACE = $NETWORK_BROADCAST_PRIVATE_INTERFACE
echo NETWORK_GATEWAY_PRIVATE_INTERFACE = $NETWORK_GATEWAY_PRIVATE_INTERFACE

echo NETWORK_EXTERNAL_INTERFACE_NAME = $NETWORK_EXTERNAL_INTERFACE_NAME

echo METADATA_SECRET = $METADATA_SECRET 
echo DATABASE_PASSWORD = $DATABASE_PASSWORD
echo RABBIT_PASS = $RABBIT_PASS
echo KEYSTONE_DBPASS = $KEYSTONE_DBPASS
echo DEMO_PASS = $DEMO_PASS
echo ADMIN_PASS = $ADMIN_PASS
echo GLANCE_DBPASS = $GLANCE_DBPASS
echo GLANCE_PASS = $GLANCE_PASS
echo NOVA_DBPASS = $NOVA_DBPASS
echo NOVA_PASS= $NOVA_PASS
echo DASH_DBPASS = $DASH_DBPASS
echo CINDER_DBPASS = $CINDER_DBPASS
echo CINDER_PASS = $CINDER_PASS
echo NEUTRON_DBPASS = $NEUTRON_DBPASS
echo NEUTRON_PASS = $NEUTRON_PASS
echo HEAT_DBPASS = $HEAT_DBPASS
echo HEAT_PASS = $HEAT_PASS
echo CEILOMETER_DBPASS = $CEILOMETER_DBPASS
echo CEILOMETER_PASS = $CEILOMETER_PASS
echo TROVE_DBPASS = $TROVE_DBPASS
echo TROVE_PASS = $TROVE_PASS



sudo echo ---- If above information is correct then- Press y to continue------
sudo echo ---- otherwise add configurations in- ~/pullstack/autostack/autostack.properties -----

echo --- Press[y/n] to continue- or to skip------
read choice

if [ "$choice" = "y" ]; then


#---------------------- Create User [ START ] ---------------------------------------------
user=$(cut -d: -f1 /etc/passwd | grep autostack)

if [ -z "$user" ]
then
sudo useradd -m -p autostack autostack
echo -e 'autostack\nautostack\n' | sudo passwd autostack || usercreate=false
if [ -s ~/pullstack/autostack/conf/common/autostack ]; then
        sudo cp ~/pullstack/autostack/conf/common/autostack /etc/sudoers.d/     
        fi
if [ "$usercreate" = true ]; then
echo ----------------------------------------
echo \|   Created a new super-user : autostack \|
echo \|   Password of autostack  : autostack . \|
echo ----------------------------------------
source=~/pullstack
destination=/home/autostack/

if [ ! -d "$destination" ]; then
    mkdir -p "$destination"
fi
sudo cp -R "$source" "$destination"
fi
fi
#---------------------- Create User [ ENDS ] ---------------------------------------------


presentdir=$(pwd)

cd /home/autostack/pullstack/autostack/conf/

echo -- Adding user configurations to files [ START ] --
find . -type f -print0 | xargs -0 sed -i "s/ACCOUNT_USERNAME/$ACCOUNT_USERNAME/g"

find . -type f -print0 | xargs -0 sed -i "s/ACCOUNT_PASSWORD/$ACCOUNT_PASSWORD/g"

find . -type f -print0 | xargs -0 sed -i "s/NAMESERVER_IP/$NAMESERVER_IP/g"

find . -type f -print0 | xargs -0 sed -i "s/CONTROLLER_NODE_HOSTNAME/$CONTROLLER_NODE_HOSTNAME/g"

find . -type f -print0 | xargs -0 sed -i "s/CONTROLLER_NODE_PUBLIC_IP/$CONTROLLER_NODE_PUBLIC_IP/g"

find . -type f -print0 | xargs -0 sed -i "s/CONTROLLER_NODE_PRIVATE_IP/$CONTROLLER_NODE_PRIVATE_IP/g"

find . -type f -print0 | xargs -0 sed -i "s/NETWORK_NODE_HOSTNAME/$NETWORK_NODE_HOSTNAME/g"

find . -type f -print0 | xargs -0 sed -i "s/NETWORK_NODE_PUBLIC_IP/$NETWORK_NODE_PUBLIC_IP/g"

find . -type f -print0 | xargs -0 sed -i "s/NETWORK_NODE_PRIVATE_IP/$NETWORK_NODE_PRIVATE_IP/g"

find . -type f -print0 | xargs -0 sed -i "s/COMPUTE_NODE_HOSTNAME/$COMPUTE_NODE_HOSTNAME/g"

find . -type f -print0 | xargs -0 sed -i "s/COMPUTE_NODE_PUBLIC_IP/$COMPUTE_NODE_PUBLIC_IP/g"

find . -type f -print0 | xargs -0 sed -i "s/COMPUTE_NODE_PRIVATE_IP/$COMPUTE_NODE_PRIVATE_IP/g"

find . -type f -print0 | xargs -0 sed -i "s/FLOATING_IP_START/$FLOATING_IP_START/g"

find . -type f -print0 | xargs -0 sed -i "s/FLOATING_IP_END/$FLOATING_IP_END/g"

find . -type f -print0 | xargs -0 sed -i "s/EXTERNAL_NETWORK_GATEWAY/$EXTERNAL_NETWORK_GATEWAY/g"

find . -type f -print0 | xargs -0 sed -i "s/EXTERNAL_NETWORK_CIDR/$EXTERNAL_NETWORK_CIDR/g"

find . -type f -print0 | xargs -0 sed -i "s/TENANT_NETWORK_GATEWAY/$TENANT_NETWORK_GATEWAY/g"

find . -type f -print0 | xargs -0 sed -i "s/TENANT_NETWORK_CIDR/$TENANT_NETWORK_CIDR/g"

find . -type f -print0 | xargs -0 sed -i "s/NETWORK_PUBLIC_INTERFACE_NAME/$NETWORK_PUBLIC_INTERFACE_NAME/g"

find . -type f -print0 | xargs -0 sed -i "s/NETWORK_NETMASK_PUBLIC_INTERFACE/$NETWORK_NETMASK_PUBLIC_INTERFACE/g"

find . -type f -print0 | xargs -0 sed -i "s/NETWORK_NETWORK_PUBLIC_INTERFACE/$NETWORK_NETWORK_PUBLIC_INTERFACE/g"

find . -type f -print0 | xargs -0 sed -i "s/NETWORK_BROADCAST_PUBLIC_INTERFACE/$NETWORK_BROADCAST_PUBLIC_INTERFACE/g"

find . -type f -print0 | xargs -0 sed -i "s/NETWORK_GATEWAY_PUBLIC_INTERFACE/$NETWORK_GATEWAY_PUBLIC_INTERFACE/g"

find . -type f -print0 | xargs -0 sed -i "s/NETWORK_PRIVATE_INTERFACE_NAME/$NETWORK_PRIVATE_INTERFACE_NAME/g"

find . -type f -print0 | xargs -0 sed -i "s/NETWORK_NETMASK_PRIVATE_INTERFACE/$NETWORK_NETMASK_PRIVATE_INTERFACE/g"

find . -type f -print0 | xargs -0 sed -i "s/NETWORK_NETWORK_PRIVATE_INTERFACE/$NETWORK_NETWORK_PRIVATE_INTERFACE/g"

find . -type f -print0 | xargs -0 sed -i "s/NETWORK_BROADCAST_PRIVATE_INTERFACE/$NETWORK_BROADCAST_PRIVATE_INTERFACE/g"

find . -type f -print0 | xargs -0 sed -i "s/NETWORK_GATEWAY_PRIVATE_INTERFACE/$NETWORK_GATEWAY_PRIVATE_INTERFACE/g"

find . -type f -print0 | xargs -0 sed -i "s/NETWORK_EXTERNAL_INTERFACE_NAME/$NETWORK_EXTERNAL_INTERFACE_NAME/g"

find . -type f -print0 | xargs -0 sed -i "s/DATABASE_PASSWORD/$DATABASE_PASSWORD/g"

find . -type f -print0 | xargs -0 sed -i "s/RABBIT_PASS/$RABBIT_PASS/g"

find . -type f -print0 | xargs -0 sed -i "s/KEYSTONE_DBPASS/$KEYSTONE_DBPASS/g"

find . -type f -print0 | xargs -0 sed -i "s/DEMO_PASS/$DEMO_PASS/g"

find . -type f -print0 | xargs -0 sed -i "s/ADMIN_PASS/$ADMIN_PASS/g"

find . -type f -print0 | xargs -0 sed -i "s/GLANCE_DBPASS/$GLANCE_DBPASS/g"

find . -type f -print0 | xargs -0 sed -i "s/GLANCE_PASS/$GLANCE_PASS/g"

find . -type f -print0 | xargs -0 sed -i "s/NOVA_DBPASS/$NOVA_DBPASS/g"

find . -type f -print0 | xargs -0 sed -i "s/NOVA_PASS/$NOVA_PASS/g"

find . -type f -print0 | xargs -0 sed -i "s/DASH_DBPASS/$DASH_DBPASS/g"

find . -type f -print0 | xargs -0 sed -i "s/CINDER_DBPASS/$CINDER_DBPASS/g"

find . -type f -print0 | xargs -0 sed -i "s/CINDER_PASS/$CINDER_PASS/g"

find . -type f -print0 | xargs -0 sed -i "s/NEUTRON_DBPASS/$NEUTRON_DBPASS/g"

find . -type f -print0 | xargs -0 sed -i "s/NEUTRON_PASS/$NEUTRON_PASS/g"

find . -type f -print0 | xargs -0 sed -i "s/HEAT_DBPASS/$HEAT_DBPASS/g"

find . -type f -print0 | xargs -0 sed -i "s/HEAT_PASS/$HEAT_PASS/g"

find . -type f -print0 | xargs -0 sed -i "s/CEILOMETER_DBPASS/$CEILOMETER_DBPASS/g"

find . -type f -print0 | xargs -0 sed -i "s/CEILOMETER_PASS/$CEILOMETER_PASS/g"

find . -type f -print0 | xargs -0 sed -i "s/TROVE_DBPASS/$TROVE_DBPASS/g"

find . -type f -print0 | xargs -0 sed -i "s/TROVE_PASS/$TROVE_PASS/g"

cd "$presentdir"

cd ~/pullstack/autostack/conf/

find . -type f -print0 | xargs -0 sed -i "s/ACCOUNT_USERNAME/$ACCOUNT_USERNAME/g"

find . -type f -print0 | xargs -0 sed -i "s/ACCOUNT_PASSWORD/$ACCOUNT_PASSWORD/g"

find . -type f -print0 | xargs -0 sed -i "s/NAMESERVER_IP/$NAMESERVER_IP/g"

find . -type f -print0 | xargs -0 sed -i "s/CONTROLLER_NODE_HOSTNAME/$CONTROLLER_NODE_HOSTNAME/g"

find . -type f -print0 | xargs -0 sed -i "s/CONTROLLER_NODE_PUBLIC_IP/$CONTROLLER_NODE_PUBLIC_IP/g"

find . -type f -print0 | xargs -0 sed -i "s/CONTROLLER_NODE_PRIVATE_IP/$CONTROLLER_NODE_PRIVATE_IP/g"

find . -type f -print0 | xargs -0 sed -i "s/NETWORK_NODE_HOSTNAME/$NETWORK_NODE_HOSTNAME/g"

find . -type f -print0 | xargs -0 sed -i "s/NETWORK_NODE_PUBLIC_IP/$NETWORK_NODE_PUBLIC_IP/g"

find . -type f -print0 | xargs -0 sed -i "s/NETWORK_NODE_PRIVATE_IP/$NETWORK_NODE_PRIVATE_IP/g"

find . -type f -print0 | xargs -0 sed -i "s/COMPUTE_NODE_HOSTNAME/$COMPUTE_NODE_HOSTNAME/g"

find . -type f -print0 | xargs -0 sed -i "s/COMPUTE_NODE_PUBLIC_IP/$COMPUTE_NODE_PUBLIC_IP/g"

find . -type f -print0 | xargs -0 sed -i "s/COMPUTE_NODE_PRIVATE_IP/$COMPUTE_NODE_PRIVATE_IP/g"

find . -type f -print0 | xargs -0 sed -i "s/FLOATING_IP_START/$FLOATING_IP_START/g"

find . -type f -print0 | xargs -0 sed -i "s/FLOATING_IP_END/$FLOATING_IP_END/g"

find . -type f -print0 | xargs -0 sed -i "s/EXTERNAL_NETWORK_GATEWAY/$EXTERNAL_NETWORK_GATEWAY/g"

find . -type f -print0 | xargs -0 sed -i "s/EXTERNAL_NETWORK_CIDR/$EXTERNAL_NETWORK_CIDR/g"

find . -type f -print0 | xargs -0 sed -i "s/TENANT_NETWORK_GATEWAY/$TENANT_NETWORK_GATEWAY/g"

find . -type f -print0 | xargs -0 sed -i "s/TENANT_NETWORK_CIDR/$TENANT_NETWORK_CIDR/g"

find . -type f -print0 | xargs -0 sed -i "s/NETWORK_PUBLIC_INTERFACE_NAME/$NETWORK_PUBLIC_INTERFACE_NAME/g"

find . -type f -print0 | xargs -0 sed -i "s/NETWORK_NETMASK_PUBLIC_INTERFACE/$NETWORK_NETMASK_PUBLIC_INTERFACE/g"

find . -type f -print0 | xargs -0 sed -i "s/NETWORK_NETWORK_PUBLIC_INTERFACE/$NETWORK_NETWORK_PUBLIC_INTERFACE/g"

find . -type f -print0 | xargs -0 sed -i "s/NETWORK_BROADCAST_PUBLIC_INTERFACE/$NETWORK_BROADCAST_PUBLIC_INTERFACE/g"

find . -type f -print0 | xargs -0 sed -i "s/NETWORK_GATEWAY_PUBLIC_INTERFACE/$NETWORK_GATEWAY_PUBLIC_INTERFACE/g"

find . -type f -print0 | xargs -0 sed -i "s/NETWORK_PRIVATE_INTERFACE_NAME/$NETWORK_PRIVATE_INTERFACE_NAME/g"

find . -type f -print0 | xargs -0 sed -i "s/NETWORK_NETMASK_PRIVATE_INTERFACE/$NETWORK_NETMASK_PRIVATE_INTERFACE/g"

find . -type f -print0 | xargs -0 sed -i "s/NETWORK_NETWORK_PRIVATE_INTERFACE/$NETWORK_NETWORK_PRIVATE_INTERFACE/g"

find . -type f -print0 | xargs -0 sed -i "s/NETWORK_BROADCAST_PRIVATE_INTERFACE/$NETWORK_BROADCAST_PRIVATE_INTERFACE/g"

find . -type f -print0 | xargs -0 sed -i "s/NETWORK_GATEWAY_PRIVATE_INTERFACE/$NETWORK_GATEWAY_PRIVATE_INTERFACE/g"

find . -type f -print0 | xargs -0 sed -i "s/NETWORK_EXTERNAL_INTERFACE_NAME/$NETWORK_EXTERNAL_INTERFACE_NAME/g"

find . -type f -print0 | xargs -0 sed -i "s/DATABASE_PASSWORD/$DATABASE_PASSWORD/g"

find . -type f -print0 | xargs -0 sed -i "s/RABBIT_PASS/$RABBIT_PASS/g"

find . -type f -print0 | xargs -0 sed -i "s/KEYSTONE_DBPASS/$KEYSTONE_DBPASS/g"

find . -type f -print0 | xargs -0 sed -i "s/DEMO_PASS/$DEMO_PASS/g"

find . -type f -print0 | xargs -0 sed -i "s/ADMIN_PASS/$ADMIN_PASS/g"

find . -type f -print0 | xargs -0 sed -i "s/GLANCE_DBPASS/$GLANCE_DBPASS/g"

find . -type f -print0 | xargs -0 sed -i "s/GLANCE_PASS/$GLANCE_PASS/g"

find . -type f -print0 | xargs -0 sed -i "s/NOVA_DBPASS/$NOVA_DBPASS/g"

find . -type f -print0 | xargs -0 sed -i "s/NOVA_PASS/$NOVA_PASS/g"

find . -type f -print0 | xargs -0 sed -i "s/DASH_DBPASS/$DASH_DBPASS/g"

find . -type f -print0 | xargs -0 sed -i "s/CINDER_DBPASS/$CINDER_DBPASS/g"

find . -type f -print0 | xargs -0 sed -i "s/CINDER_PASS/$CINDER_PASS/g"

find . -type f -print0 | xargs -0 sed -i "s/NEUTRON_DBPASS/$NEUTRON_DBPASS/g"

find . -type f -print0 | xargs -0 sed -i "s/NEUTRON_PASS/$NEUTRON_PASS/g"

find . -type f -print0 | xargs -0 sed -i "s/HEAT_DBPASS/$HEAT_DBPASS/g"

find . -type f -print0 | xargs -0 sed -i "s/HEAT_PASS/$HEAT_PASS/g"

find . -type f -print0 | xargs -0 sed -i "s/CEILOMETER_DBPASS/$CEILOMETER_DBPASS/g"

find . -type f -print0 | xargs -0 sed -i "s/CEILOMETER_PASS/$CEILOMETER_PASS/g"

find . -type f -print0 | xargs -0 sed -i "s/TROVE_DBPASS/$TROVE_DBPASS/g"

find . -type f -print0 | xargs -0 sed -i "s/TROVE_PASS/$TROVE_PASS/g"

echo -- Adding user configurations to files [ ENDS ] --

cd "$presentdir"

echo  ---------------------------------------------------------------------------------------------------------------------------------------------
echo \|  [ NOTE : Verify Your configuration at ~/pullstack/autostack/conf/check_autostack_configuration.txt and then- only move to next Step ] \|
echo   ---------------------------------------------------------------------------------------------------------------------------------------------
echo
echo



fi


echo -----------------############### LEAVING REPLACE CONTROLLER.SH FILE -###############-----------------

exit

