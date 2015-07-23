#!/bin/bash


. ~/pullstack/autostack/conf/linecounterfiles/controller.properties
. ~/pullstack/autostack/conf/autostack.properties

echo ------------------ NOVA INSTALLATION  ---------------------------------------------

#-------------- Check if PREVIOUS script is executed successfully or not [ STARTS ] ---------------------------------
checklastshellscriptexecution=$(cat /etc/network/interfaces | grep "$NETWORK_NETMASK_PUBLIC_INTERFACE")
if [ -z "$checklastshellscriptexecution" ]
then
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

echo Created a new super-user : autostack
echo Password :  autostack
fi
fi
echo Last Shell Script is not Executed Properly. Executing it Again may reboot system.
echo After computer reboots, Run This Shell Script Again.


sudo chmod 755 ~/pullstack/autostack/scripts/controller/replace.sh
( exec "$HOME/pullstack/autostack/scripts/controller/./replace.sh" )
sudo chmod 755 ~/pullstack/autostack/scripts/controller/controllerfirst.sh
( exec "$HOME/pullstack/autostack/scripts/controller/./controllerfirst.sh" )

echo   ---------------------------------------------------------------------------------------------------------------------------------------------
echo \|  [ NOTE : Check file- at ~/pullstack/autostack/conf/controller/interfaces and if- file- exist and have correct configuration then- manually copy it to /etc/network/interfaces , Otherwise Download \'AutoStack\'  again and check same file-] \|
echo   ---------------------------------------------------------------------------------------------------------------------------------------------
fi
#-------------- Check if PREVIOUS script is executed successfully or not [ ENDS ] ---------------------------------


#-------------- Check if PRESENT script is already executed [ START ] ---------------------------------
if [ "$controllerfifth" -eq 15 ]; then

echo -----------------------------------------------------
echo \|   This Shell Script has been Executed Successfully. \|
echo -----------------------------------------------------

echo If you Want to execute it again Press [y/n] to Execute it.
read -r userchoice
     if [ "$userchoice" = "y" ]; then
     echo Enter Line Number you want to continue: [Valid 1 - 15] 
     echo And Execute it again.
     read -r againlinenumber

    sed "s/controllerfifth=.*/controllerfifth=$againlinenumber/g" ~/pullstack/autostack/linecounterfiles/controller.properties > tmp
    mv tmp ~/pullstack/autostack/linecounterfiles/controller.properties 
fi

exit
else

echo Starting $filename
fi


#-------------- Check if PRESENT script is already executed [ ENDS ] ---------------------------------


check=true
filename=$(basename "$0")
today=$(date +%Y-%m-%d.%H:%M:%S)


exec 2> >(tee "Error_.$filename._.$today.err")
exec > >(tee "Log_.$filename._.$today.log")


echo DATABASE_PASSWORD = "$DATABASE_PASSWORD"
echo CONTROLLER_NODE_HOSTNAME = "$CONTROLLER_NODE_HOSTNAME"
echo CONTROLLER_NODE_PUBLIC_IP = "$CONTROLLER_NODE_PUBLIC_IP"
echo CONTROLLER_NODE_PRIVATE_IP = "$CONTROLLER_NODE_PRIVATE_IP"
echo NETWORK_NODE_HOSTNAME = "$NETWORK_NODE_HOSTNAME"
echo NETWORK_NODE_PUBLIC_IP = "$NETWORK_NODE_PUBLIC_IP"
echo NETWORK_NODE_PRIVATE_IP = "$NETWORK_NODE_PRIVATE_IP"
echo COMPUTE_NODE_HOSTNAME = "$COMPUTE_NODE_HOSTNAME"
echo COMPUTE_NODE_PUBLIC_IP = "$COMPUTE_NODE_PUBLIC_IP"
echo COMPUTE_NODE_PRIVATE_IP = "$COMPUTE_NODE_PRIVATE_IP"

#echo ======= Counter Value is $controllerone =============

sudo echo ---- If above information is correct then- Press y to continue------
sudo echo ---- otherwise add configurations in- ~/pullstack/autostack/autostack.properties -----

echo --- Press[y/n] to continue- or to skip------

read -r choice
if [ "$choice" = "y" ]; then



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
                              
                               #sudo replace "NAMESERVER_IP" $NAMESERVER_IP -- ~/pullstack/autostack/conf/common/*
                               sudo sed -i -e "s/NAMESERVER_IP/$NAMESERVER_IP/g" ~/pullstack/autostack/conf/common/*
                               updatednameserverip=$(cat ~/pullstack/autostack/conf/common/resolv.conf | grep "$NAMESERVER_IP")
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



#-------------------------- Copying admin-openrc.sh & demo-openrc.sh [STARTS] ----------------------------------------
if [ ! -s admin-openrc.sh ]; then
pwdd=$(pwd)
sudo cp ~/pullstack/autostack/conf/controller/admin-openrc.sh $pwdd
sudo sed -i -e "s/ADMIN_PASS/$ADMIN_PASS/g" admin-openrc.sh
sudo sed -i -e "s/CONTROLLER_NODE_HOSTNAME/$CONTROLLER_NODE_HOSTNAME/g" admin-openrc.sh
fi

if [ ! -s demo-openrc.sh ]; then
pwdd=$(pwd)
sudo cp ~/pullstack/autostack/conf/controller/demo-openrc.sh $pwdd
sudo sed -i -e "s/DEMO_PASS/$DEMO_PASS/g" demo-openrc.sh
sudo sed -i -e "s/CONTROLLER_NODE_HOSTNAME/$CONTROLLER_NODE_HOSTNAME/g" demo-openrc.sh
fi
#-------------------------- Copying admin-openrc.sh & demo-openrc.sh [ENDS] ----------------------------------------



if [ "$check" = true ] && [ "$controllerfifth" -eq 1 ]; then

####################################################################################

MYSQL=`which mysql`
 
Q1="CREATE DATABASE IF NOT EXISTS neutron;"

Q2="GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'localhost' \
  IDENTIFIED BY '$NEUTRON_DBPASS';"
Q3="GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'%' \
  IDENTIFIED BY '$NEUTRON_DBPASS';"
Q4="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}${Q4}"
 

$MYSQL -uroot -p$DATABASE_PASSWORD -e "$SQL" || check=false

if [ "$check" = true ]; then
echo ------- Glance Database is Created -------
fi

############################## keystone database created ##################################

echo ------------------"$filename" line no : "$controllerfifth"------------------------
#line no 1
((controllerfifth=controllerfifth+1))
fi


if [ "$check" = true ] && [ "$controllerfifth" -eq 2 ]; then
source admin-openrc.sh || check=false 
echo ------------------"$filename" line no : "$controllerfifth"------------------------
#line no 2
((controllerfifth=controllerfifth+1))
fi


if [ "$check" = true ] && [ "$controllerfifth" -eq 3 ]; then
keystone user-create --name neutron --pass $NEUTRON_PASS || check=false 

echo ------------------"$filename" line no : "$controllerfifth"------------------------
#line no 3
((controllerfifth=controllerfifth+1))
fi


if [ "$check" = true ] && [ "$controllerfifth" -eq 4 ]; then
keystone user-role-add --user neutron --tenant service --role admin || check=false

echo ------------------"$filename" line no : "$controllerfifth"------------------------
#line no 4
((controllerfifth=controllerfifth+1))
fi


if [ "$check" = true ] && [ "$controllerfifth" -eq 5 ]; then
keystone service-create --name neutron --type network \
  --description "OpenStack Networking" || check=false 
echo ------------------"$filename" line no : "$controllerfifth"------------------------
#line no 5
((controllerfifth=controllerfifth+1))
fi


if [ "$check" = true ] && [ "$controllerfifth" -eq 6 ]; then

keystone endpoint-create \
  --service-id $(keystone service-list | awk '/ network / {print $2}') \
  --publicurl http://$CONTROLLER_NODE_HOSTNAME:9696 \
  --adminurl http://$CONTROLLER_NODE_HOSTNAME:9696 \
  --internalurl http://$CONTROLLER_NODE_HOSTNAME:9696 \
  --region regionOne
echo ------------------"$filename" line no : "$controllerfifth"------------------------
#line no 6
((controllerfifth=controllerfifth+1))
fi

if [ "$check" = true ] && [ "$controllerfifth" -eq 7 ]; then
sudo pt-get install neutron-server neutron-plugin-ml2 python-neutronclient -y || check=false
echo ------------------"$filename" line no : "$controllerfifth"------------------------
#line no 7
((controllerfifth=controllerfifth+1))
fi


if [ "$check" = true ] && [ "$controllerfifth" -eq 8 ]; then

source admin-openrc.sh
keystone tenant-get service || check=false
SERVICE_TENANT_ID=$(keystone tenant-get service|grep id| cut -d '|' -f 3) || check=false
echo SERVICE_TENANT_ID = "$SERVICE_TENANT_ID"
sudo sed -i -e "s/SERVICE_TENANT_ID/$SERVICE_TENANT_ID/g" ~/pullstack/autostack/conf/controller/neutron.conf || check=false

if [ "$check" = true ]; then
echo SERVICE_TENANT_ID is replaced -in -~/pullstack/autostack/conf/controller/neutron.conf
else 
echo [ NOTE : SERVICE_TENANT_ID is NOT replaced -in ~/pullstack/autostack/conf/controller/neutron.conf ]
echo Replace it manually.
fi




if [ -s ~/pullstack/autostack/conf/controller/neutron.conf ]; then
sudo rm -rf /etc/neutron/neutron.conf || check=false
sudo cp ~/pullstack/autostack/conf/controller/neutron.conf /etc/neutron/ || check=false
else
echo --------------------------------------------------------------------------------
echo ----------- NEUTRON : /etc/neutron/neutron.conf  [ NOT EDITED ] -------------
echo -----------------------------------------------------------------------------------
fi
echo ------------------"$filename" line no : "$controllerfifth"------------------------
#line no 8
((controllerfifth=controllerfifth+1))
fi


if [ "$check" = true ] && [ "$controllerfifth" -eq 10 ]; then

if [ -s ~/pullstack/autostack/conf/controller/ml2_conf.ini ]; then
sudo rm -rf /etc/neutron/plugins/ml2/ml2_conf.ini || check=false
sudo cp ~/pullstack/autostack/conf/controller/ml2_conf.ini /etc/neutron/plugins/ml2/ || check=false
else
echo --------------------------------------------------------------------------------
echo ----------- NEUTRON : /etc/neutron/plugins/ml2/ml2_conf.ini  [ NOT EDITED ] -------------
echo -----------------------------------------------------------------------------------
fi
echo ------------------"$filename" line no : "$controllerfifth"------------------------
#line no 10
((controllerfifth=controllerfifth+1))
fi


if [ "$check" = true ] && [ "$controllerfifth" -eq 11 ]; then

if [ -s ~/pullstack/autostack/conf/controller/network_nova/nova.conf ]; then
sudo rm -rf /etc/nova/nova.conf || check=false
sudo cp ~/pullstack/autostack/conf/controller/network_nova/nova.conf /etc/nova/ || check=false
else
echo --------------------------------------------------------------------------------
echo ----------- NEUTRON-NOVA [controller] : /etc/nova/nova.conf  [ NOT EDITED ] -------------
echo -----------------------------------------------------------------------------------
fi
echo ------------------"$filename" line no : "$controllerfifth"------------------------
#line no 11
((controllerfifth=controllerfifth+1))
fi

if [ "$check" = true ] && [ "$controllerfifth" -eq 12 ]; then
su -s /bin/sh -c "neutron-db-manage --config-file /etc/neutron/neutron.conf \
  --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade juno" neutron || check=false
echo ------------------"$filename" line no : "$controllerfifth"------------------------
#line no 12
((controllerfifth=controllerfifth+1))
fi


if [ "$check" = true ] && [ "$controllerfifth" -eq 13 ]; then
sudo service nova-api restart || check=false
sudo service nova-cert restart || check=false
sudo service nova-consoleauth restart || check=false
sudo service nova-scheduler restart || check=false
sudo service nova-conductor restart || check=false
sudo service nova-novncproxy restart || check=false
sudo service neutron-server restart || check=false
echo ------------------"$filename" line no : "$controllerfifth"------------------------
#line no 13
((controllerfifth=controllerfifth+1))
fi

if [ "$check" = true ] && [ "$controllerfifth" -eq 14 ]; then
source admin-openrc.sh || check=false
neutron ext-list || check=false
echo ------------------"$filename" line no : "$controllerfifth"------------------------
#line no 14
((controllerfifth=controllerfifth+1))
fi

if [ "$check" = true ] && [ "$controllerfifth" -eq 15 ]; then
echo ---======---  Installing NETWORK Services - Network Node ---======---
echo --- Going To Network Node ---
sshpass -p autostack ssh -o StrictHostKeyChecking=no autostack@$NETWORK_NODE_PUBLIC_IP "sudo -u root  ~/pullstack/autostack/network/./networknetwork.sh" || check=false
echo ------------------"$filename" line no : "$controllerfifth"------------------------
#line no 15
((controllerfifth=controllerfifth+1))
fi


if [ "$check" = true ] && [ "$controllerfifth" -eq 16 ]; then

if [ -s ~/pullstack/autostack/conf/controller/network_nova/netwotk_network_nova/nova.conf ]; then
sudo rm -rf /etc/nova/nova.conf || check=false
sudo cp ~/pullstack/autostack/conf/controller/network_nova/netwotk_network_nova/nova.conf /etc/nova/ || check=false
sudo service nova-api restart || check=false
else
echo --------------------------------------------------------------------------------
echo ----------- NEUTRON-NOVA [network on controller] : /etc/nova/nova.conf  [ NOT EDITED ] -------------
echo -----------------------------------------------------------------------------------
fi
echo ------------------"$filename" line no : "$controllerfifth"------------------------
#line no 16
((controllerfifth=controllerfifth+1))
fi

if [ "$check" = true ] && [ "$controllerfifth" -eq 17 ]; then
echo -------- NOVA ON COMPUTE [GOING TO COMPUTE NODE] -----------

sshpass -p autostack ssh -o StrictHostKeyChecking=no autostack@$NETWORK_NODE_PUBLIC_IP "sudo -u root  ~/pullstack/autostack/network/./networknetworksecond.sh" || check=false
echo ------------------"$filename" line no : "$controllerfifth"------------------------
#line no 17
((controllerfifth=controllerfifth+1))
fi


if [ "$check" = true ] && [ "$controllerfifth" -eq 18 ]; then
echo ----------  "Verifying Operation - NETWORK [Network] SERVICE" ----------
source admin-openrc.sh || check=false
neutron agent-list || check=false
echo   -----------------------------------------------
echo \|  [ NOTE : It Should contain 4 Network Services. . ] \|
echo   -----------------------------------------------

echo ------------------"$filename" line no : "$controllerfifth"------------------------
#line no 18
((controllerfifth=controllerfifth+1))
fi

if [ "$check" = true ] && [ "$controllerfifth" -eq 19 ]; then
echo ---======---  Installing NETWORK Services - Compute Node ---======---
echo --- Going To Compute Node ---
sshpass -p autostack ssh -o StrictHostKeyChecking=no autostack@$COMPUTE_NODE_PUBLIC_IP "sudo -u root  ~/pullstack/autostack/compute/./computenetwork.sh" || check=false
echo ------------------"$filename" line no : "$controllerfifth"------------------------
#line no 19
((controllerfifth=controllerfifth+1))
fi


if [ "$check" = true ] && [ "$controllerfifth" -eq 20 ]; then
echo ------------  "Verifying Operation - NETWORK [Compute] SERVICE" ------------
source admin-openrc.sh || check=false
neutron agent-list || check=false
echo   ------------------------------------------------------
echo \|  [ NOTE : It Should contain Compute Open vSwitch agent. . ] \|
echo   ------------------------------------------------------

echo ------------------"$filename" line no : "$controllerfifth"------------------------

((controllerfifth=controllerfifth+1))


sed "s/controllerfifth=.*/controllerfifth="$controllerfifth"/g" ~/pullstack/autostack/conf/linecounterfiles/controller.properties > tmp
   mv tmp ~/pullstack/autostack/conf/linecounterfiles/controller.properties
echo   -----------------------------------------------
echo \|  [ NOTE : This shell script executed Successfully . ] \|
echo   -----------------------------------------------

exit
#line no 20
((controllerfifth=controllerfifth+1))
fi
######################################################################################################


((controllerfifth=controllerfifth-1))

echo   ---------------------------------------------------------------------------------------------------------------------------------------------
echo \|  [ NOTE : Shell Script Execution Terminated at Line Number : "$controllerfifth" , Verify this line and execute same shell script again and it will start there itself . ] \|
echo   ---------------------------------------------------------------------------------------------------------------------------------------------


sed "s/controllerfifth=.*/controllerfifth="$controllerfifth"/g" ~/pullstack/autostack/conf/linecounterfiles/controller.properties > tmp
   mv tmp ~/pullstack/autostack/conf/linecounterfiles/controller.properties


fi
exit
