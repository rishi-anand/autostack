#!/bin/bash

. ~/pullstack/autostack/linecounterfiles/controller.properties

. autostack.properties

check=true
filename=`basename "$0"`
today=`date +%Y-%m-%d.%H:%M:%S`


exec 2> >(tee "Error_.$filename._.$today.err")
exec > >(tee "Log_.$filename._.$today.log")



# Define your function here
line_counter_increment () {
   sed "s/controllerone=.*/controllerone=$count/g" ~/pullstack/autostack/linecounterfiles/controller.properties > tmp
   mv tmp ~/pullstack/autostack/linecounterfiles/controller.properties
   
   
   return $controllerone
}







echo ACCOUNT_USERNAME = $ACCOUNT_USERNAME
echo ACCOUNT_PASSWORD = $ACCOUNT_PASSWORD

echo CONTROLLER_NODE_HOSTNAME = $CONTROLLER_NODE_HOSTNAME
echo CONTROLLER_NODE_PUBLIC_IP = $CONTROLLER_NODE_PUBLIC_IP
echo CONTROLLER_NODE_PRIVATE_IP = $CONTROLLER_NODE_PRIVATE_IP

echo NETWORK_NODE_HOSTNAME = $NETWORK_NODE_HOSTNAME
echo NETWORK_NODE_PUBLIC_IP = $NETWORK_NODE_PUBLIC_IP
echo NETWORK_NODE_PRIVATE_IP = $NETWORK_NODE_PRIVATE_IP

echo COMPUTE_NODE_HOSTNAME = $COMPUTE_NODE_HOSTNAME
echo COMPUTE_NODE_PUBLIC_IP = $COMPUTE_NODE_PUBLIC_IP
echo COMPUTE_NODE_PRIVATE_IP = $COMPUTE_NODE_PRIVATE_IP


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







echo ---- If above information is correct then- Press y to continue------
echo ---- otherwise add configurations in- ~/pullstack/autostack/autostack.properties -----

echo --- Press[y/n] to continue- or to skip------

read choice
if [ "$choice" = "y" ]; then


if [ "$check" = true ] && [ $controllerone -eq 1 ]; then
        if [ -s ~/pullstack/autostack/conf/common/resolv.conf ]; then
        #sudo rm -rf /etc/resolv.conf || (check=false && line_counter_increment 1 )
        pwd
        fi
echo -------------------$filename line no : $controllerone------------------------
#line no 1
((controllerone=controllerone+1))
fi

if [ "$check" = true ] && [ $controllerone -eq 2 ]; then
       if [ -s ~/pullstack/autostack/conf/common/resolv.conf ]; then
       #sudo cp ~/pullstack/autostack/conf/common/resolv.conf /etc/ || (check=false && line_counter_increment 2 )
       pwd
       fi
echo -------------------$filename line no : $controllerone------------------------
#line no 2
((controllerone=controllerone+1))
fi

if [ "$check" = true ] && [ $controllerone -eq 3 ]; then



sudo apt-get update || (check=false && line_counter_increment 3 )
echo -------------------$filename line no : $controllerone------------------------
#line no 3
((controllerone=controllerone+1))
fi

if [ "$check" = true ] && [ $controllerone -eq 4 ]; then


echo -------- installing openssh server ----------
sudo apt-get install openssh-server -y || (check=false && line_counter_increment 4 )
echo -------- installing ssh-pass -----------
sudo apt-get install sshpass -y || (check=false && line_counter_increment 4 )
echo -------------------$filename line no : $controllerone------------------------
#line no 4
((controllerone=controllerone+1))
fi

if [ "$check" = true ] && [ $controllerone -eq 5 ]; then



sudo apt-get install ubuntu-cloud-keyring || (check=false && line_counter_increment 5 )

echo -------------------$filename line no : $controllerone------------------------
#line no 5
((controllerone=controllerone+1))
fi

if [ "$check" = true ] && [ $controllerone -eq 6 ]; then


sudo echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu" \
  "trusty-updates/juno main" > /etc/apt/sources.list.d/cloudarchive-juno.list || (check=false && line_counter_increment 6 )
echo -------------------$filename line no : $controllerone------------------------
#line no 6
((controllerone=controllerone+1))
fi

if [ "$check" = true ] && [ $controllerone -eq 7 ]; then

sudo apt-get update && sudo apt-get update --fix-missing && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y || (check=false && line_counter_increment 7 )
sudo apt-get install mariadb-server python-mysqldb -y || (check=false && line_counter_increment 7 )
echo -------------------$filename line no : $controllerone------------------------
#line no 7
((controllerone=controllerone+1))
fi


if [ "$check" = true ] && [ $controllerone -eq 8 ]; then

echo -------------- REPLACING ALL PARAMETERS -----------------------------------------------------------------
sudo chmod 755 replacecontroller.sh
( exec "./replacecontroller.sh" ) || (check=false && line_counter_increment 8 )
echo -------------------$filename line no : $controllerone------------------------
#line no 8
((controllerone=controllerone+1))
fi



if [ "$check" = true ] && [ $controllerone -eq 9 ]; then

sudo chmod 700 ~/pullstack/autostack/scripts/controller/controllersecond.sh || echo "Unable to set Permission"

#chown root ~/pullstack/autostack/conf/controller/ || echo "Unable to set Permission"
sudo chmod 755 ~/pullstack/autostack/conf/controller/ || echo "Unable to set Permission"

sudo chmod u+x ~/pullstack/autostack/scripts/controller/controllersecond.sh || echo "Unable to set Permission"

#chown root ~/pullstack/autostack/conf/controller/controllerthird.sh || echo "Unable to set Permission"
sudo chmod 700 ~/pullstack/autostack/scripts/controller/controllerthird.sh || echo "Unable to set Permission"

sudo chmod u+x ~~/pullstack/autostack/scripts/controller/controllerthird.sh || echo "Unable to set Permission"

#chown root ~/pullstack/autostack/conf/controller/controllersecond.sh || echo "Unable to set Permission"
sudo chmod 700 ~/pullstack/autostack/scripts/controller/controllersecond.sh || echo "Unable to set Permission"

sudo chmod u+x ~/pullstack/autostack/scripts/controller/controllersecond.sh || echo "Unable to set Permission"
sudo chmod u+x ~/pullstack/autostack/scripts/controller/controllerthird.sh || echo "Unable to set Permission"

echo -------------------$filename line no : $controllerone------------------------
#line no 9
((controllerone=controllerone+1))

sudo chmod 755 controllerfirst.sh
echo ------------------ Now Execute controllerfirst.sh -------------------------------------

fi

fi

exit
