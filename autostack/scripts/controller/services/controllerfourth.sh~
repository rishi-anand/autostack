#!/bin/bash


. ~/pullstack/autostack/conf/linecounterfiles/controller.properties
. ~/pullstack/autostack/conf/autostack.properties

echo ------------------ NOVA INSTALLATION  ---------------------------------------------

#-------------- Check if PREVIOUS script is executed successfully or not [ STARTS ] ---------------------------------
checklastshellscriptexecution=$(cat /etc/network/interfaces | grep $NETWORK_NETMASK_PUBLIC_INTERFACE)
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
( exec "~/pullstack/autostack/scripts/controller/./replace.sh" )
sudo chmod 755 ~/pullstack/autostack/scripts/controller/controllerfirst.sh
( exec "~/pullstack/autostack/scripts/controller/./controllerfirst.sh" )

echo   ---------------------------------------------------------------------------------------------------------------------------------------------
echo \|  [ NOTE : Check file- at ~/pullstack/autostack/conf/controller/interfaces and if- file- exist and have correct configuration then- manually copy it to /etc/network/interfaces , Otherwise Download \'AutoStack\'  again and check same file-] \|
echo   ---------------------------------------------------------------------------------------------------------------------------------------------
fi
#-------------- Check if PREVIOUS script is executed successfully or not [ ENDS ] ---------------------------------


#-------------- Check if PRESENT script is already executed [ START ] ---------------------------------
if [ "$controllerfour" -eq 16 ]; then

echo -----------------------------------------------------
echo \|   This Shell Script has been Executed Successfully. \|
echo -----------------------------------------------------

echo If you Want to execute it again Press [y/n] to Execute it.
read userchoice
     if [ "$userchoice" = "y" ]; then
     echo Enter Line Number you want to continue: [Valid 1 - 15] 
     echo And Execute it again.
     read againlinenumber

    sed "s/controllerfour=.*/controllerfour=$againlinenumber/g" ~/pullstack/autostack/linecounterfiles/controller.properties > tmp
    mv tmp ~/pullstack/autostack/linecounterfiles/controller.properties 
fi

exit
else

echo Starting $filename
fi


#-------------- Check if PRESENT script is already executed [ ENDS ] ---------------------------------


check=true
filename=`basename "$0"`
today=`date +%Y-%m-%d.%H:%M:%S`


exec 2> >(tee "Error_.$filename._.$today.err")
exec > >(tee "Log_.$filename._.$today.log")


echo DATABASE_PASSWORD = $DATABASE_PASSWORD
echo CONTROLLER_NODE_HOSTNAME = $CONTROLLER_NODE_HOSTNAME
echo CONTROLLER_NODE_PUBLIC_IP = $CONTROLLER_NODE_PUBLIC_IP
echo CONTROLLER_NODE_PRIVATE_IP = $CONTROLLER_NODE_PRIVATE_IP
echo NETWORK_NODE_HOSTNAME = $NETWORK_NODE_HOSTNAME
echo NETWORK_NODE_PUBLIC_IP = $NETWORK_NODE_PUBLIC_IP
echo NETWORK_NODE_PRIVATE_IP = $NETWORK_NODE_PRIVATE_IP
echo COMPUTE_NODE_HOSTNAME = $COMPUTE_NODE_HOSTNAME
echo COMPUTE_NODE_PUBLIC_IP = $COMPUTE_NODE_PUBLIC_IP
echo COMPUTE_NODE_PRIVATE_IP = $COMPUTE_NODE_PRIVATE_IP

#echo ======= Counter Value is $controllerone =============

sudo echo ---- If above information is correct then- Press y to continue------
sudo echo ---- otherwise add configurations in- ~/pullstack/autostack/autostack.properties -----

echo --- Press[y/n] to continue- or to skip------

read choice
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




if [ "$check" = true ] && [ "$controllerfour" -eq 1 ]; then

####################################################################################

MYSQL=`which mysql`
 
Q1="CREATE DATABASE IF NOT EXISTS nova;"

Q2="GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'localhost' \
  IDENTIFIED BY '$NOVA_DBPASS';"
Q3="GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'%' \
  IDENTIFIED BY '$NOVA_DBPASS';"
Q4="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}${Q4}"
 

$MYSQL -uroot -p$DATABASE_PASSWORD -e "$SQL" || check=false

if [ "$check" = true ]; then
echo ------- Glance Database is Created -------
fi

############################## keystone database created ##################################

echo -------------------$filename line no : "$controllerfour"------------------------
#line no 1
((controllerfour=controllerfour+1))
fi


if [ "$check" = true ] && [ "$controllerfour" -eq 2 ]; then
source admin-openrc.sh || check=false 
echo -------------------$filename line no : "$controllerfour"------------------------
#line no 2
((controllerfour=controllerfour+1))
fi


if [ "$check" = true ] && [ "$controllerfour" -eq 3 ]; then
keystone user-create --name nova --pass $NOVA_PASS || check=false 

echo -------------------$filename line no : "$controllerfour"------------------------
#line no 3
((controllerfour=controllerfour+1))
fi


if [ "$check" = true ] && [ "$controllerfour" -eq 4 ]; then
keystone user-role-add --user nova --tenant service --role admin || check=false

echo -------------------$filename line no : "$controllerfour"------------------------
#line no 4
((controllerfour=controllerfour+1))
fi


if [ "$check" = true ] && [ "$controllerfour" -eq 5 ]; then
keystone service-create --name nova --type compute \
  --description "OpenStack Compute" || check=false 
echo -------------------$filename line no : "$controllerfour"------------------------
#line no 5
((controllerfour=controllerfour+1))
fi


if [ "$check" = true ] && [ "$controllerfour" -eq 6 ]; then

keystone endpoint-create \
  --service-id $(keystone service-list | awk '/ compute / {print $2}') \
  --publicurl http://$CONTROLLER_NODE_HOSTNAME:8774/v2/%\(tenant_id\)s \
  --internalurl http://$CONTROLLER_NODE_HOSTNAME:8774/v2/%\(tenant_id\)s \
  --adminurl http://$CONTROLLER_NODE_HOSTNAME:8774/v2/%\(tenant_id\)s \
  --region regionOne || check=false
echo -------------------$filename line no : "$controllerfour"------------------------
#line no 6
((controllerfour=controllerfour+1))
fi

if [ "$check" = true ] && [ "$controllerfour" -eq 7 ]; then
sudo apt-get install nova-api nova-cert nova-conductor nova-consoleauth \
  nova-novncproxy nova-scheduler python-novaclient -y || check=false
echo -------------------$filename line no : "$controllerfour"------------------------
#line no 7
((controllerfour=controllerfour+1))
fi


if [ "$check" = true ] && [ "$controllerfour" -eq 8 ]; then
if [ -s ~/pullstack/autostack/conf/controller/nova.conf ]; then
sudo rm -rf /etc/nova/nova.conf || check=false
sudo cp ~/pullstack/autostack/conf/controller/nova.conf /etc/nova/ || check=false
else
echo --------------------------------------------------------------------------------
echo ----------- NOVA : /etc/nova/nova.conf  [ NOT EDITED ] -------------
echo -----------------------------------------------------------------------------------
fi
echo -------------------$filename line no : "$controllerfour"------------------------
#line no 8
((controllerfour=controllerfour+1))
fi


if [ "$check" = true ] && [ "$controllerfour" -eq 10 ]; then
sudo su -s /bin/sh -c "nova-manage db sync" nova || check=false
echo -------------------$filename line no : "$controllerfour"------------------------
#line no 10
((controllerfour=controllerfour+1))
fi

if [ "$check" = true ] && [ "$controllerfour" -eq 11 ]; then
sudo service nova-api restart || check=false
sudo service nova-cert restart || check=false
sudo service nova-consoleauth restart || check=false
sudo service nova-scheduler restart || check=false
sudo service nova-conductor restart || check=false
sudo service nova-novncproxy restart || check=false
echo -------------------$filename line no : "$controllerfour"------------------------
#line no 11
((controllerfour=controllerfour+1))
fi

if [ "$check" = true ] && [ "$controllerfour" -eq 12 ]; then
sudo rm -f /var/lib/nova/nova.sqlite || check=false 
echo -------------------$filename line no : "$controllerfour"------------------------
#line no 12
((controllerfour=controllerfour+1))
fi

if [ "$check" = true ] && [ "$controllerfour" -eq 13 ]; then
echo -------- NOVA ON COMPUTE [GOING TO COMPUTE NODE] -----------
sshpass -p $ACCOUNT_PASSWORD ssh -o StrictHostKeyChecking=no $ACCOUNT_USERNAME@$COMPUTE_NODE_PUBLIC_IP "sudo -u root  ~/pullstack/autostack/compute/./computenova.sh" || check=false 
echo -------------------$filename line no : "$controllerfour"------------------------
#line no 13
((controllerfour=controllerfour+1))
fi


if [ "$check" = true ] && [ "$controllerfour" -eq 13 ]; then
echo ----------- VERIFYING  NOVA ------------------------------
source admin-openrc.sh || check=false
echo -------------------$filename line no : "$controllerfour"------------------------
#line no 13
((controllerfour=controllerfour+1))
fi

if [ "$check" = true ] && [ "$controllerfour" -eq 14 ]; then
echo NOVA SERVICE_LIST
echo [ It Should contain 4 controller services and 1 compute services ]
nova service-list || check=false 
echo -------------------$filename line no : "$controllerfour"------------------------
#line no 14
((controllerfour=controllerfour+1))
fi


if [ "$check" = true ] && [ "$controllerfour" -eq 15 ]; then
echo NOVA IMAGE-LIST
nova image-list || check=false 
echo -------------------$filename line no : "$controllerfour"------------------------

((controllerfour=controllerfour+1))


sed "s/controllerfour=.*/controllerfour="$controllerfour"/g" ~/pullstack/autostack/conf/linecounterfiles/controller.properties > tmp
   mv tmp ~/pullstack/autostack/conf/linecounterfiles/controller.properties
echo   -----------------------------------------------
echo \|  [ NOTE : This shell script executed Successfully . ] \|
echo   -----------------------------------------------

exit
#line no 15
((controllerfour=controllerfour+1))
fi
######################################################################################################


((controllerfour=controllerfour-1))

echo   ---------------------------------------------------------------------------------------------------------------------------------------------
echo \|  [ NOTE : Shell Script Execution Terminated at Line Number : "$controllerfour" , Verify this line and execute same shell script again and it will start there itself . ] \|
echo   ---------------------------------------------------------------------------------------------------------------------------------------------


sed "s/controllerfour=.*/controllerfour="$controllerfour"/g" ~/pullstack/autostack/conf/linecounterfiles/controller.properties > tmp
   mv tmp ~/pullstack/autostack/conf/linecounterfiles/controller.properties


fi
exit
