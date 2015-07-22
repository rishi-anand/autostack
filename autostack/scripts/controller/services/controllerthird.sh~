#!/bin/bash


. ~/pullstack/autostack/linecounterfiles/controller.properties
. ~/pullstack/autostack/autostack.properties

echo ------------------ GLANCE INSTALLATION  ---------------------------------------------

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
if [ "$controllerthree" -eq 19 ]; then

echo -----------------------------------------------------
echo \|   This Shell Script has been Executed Successfully. \|
echo -----------------------------------------------------

echo If you Want to execute it again Press [y/n] to Execute it.
read userchoice
     if [ "$userchoice" = "y" ]; then
     echo Enter Line Number you want to continue: [Valid 1 - 19] 
     echo And Execute it again.
     read againlinenumber
     
     againcheck=true
    sed "s/controllerthree=.*/controllerthree=$againlinenumber/g" ~/pullstack/autostack/linecounterfiles/controller.properties > tmp
    mv tmp ~/pullstack/autostack/linecounterfiles/controller.properties 
    controllerthree=$againlinenumber
fi

#exit
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



if [ "$check" = true ] && [ "$controllerthree" -eq 1 ]; then

####################################################################################

MYSQL=`which mysql`
 
Q1="CREATE DATABASE IF NOT EXISTS glance;"

Q2="GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'localhost' \
  IDENTIFIED BY '$GLANCE_DBPASS';"
Q3="GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'%' \
  IDENTIFIED BY '$GLANCE_DBPASS';"
Q4="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}${Q4}"
 

$MYSQL -uroot -p$DATABASE_PASSWORD -e "$SQL" || check=false

if [ "$check" = true ]; then
echo ------- Glance Database is Created -------
fi

############################## keystone database created ##################################

echo -------------------$filename line no : "$controllerthree"------------------------
#line no 1
((controllerthree=controllerthree+1))
fi


if [ "$check" = true ] && [ "$controllerthree" -eq 2 ]; then
source admin-openrc.sh || check=false 
echo -------------------$filename line no : "$controllerthree"------------------------
#line no 2
((controllerthree=controllerthree+1))
fi


if [ "$check" = true ] && [ "$controllerthree" -eq 3 ]; then
keystone user-create --name glance --pass $GLANCE_PASS || check=false 

echo -------------------$filename line no : "$controllerthree"------------------------
#line no 3
((controllerthree=controllerthree+1))
fi


if [ "$check" = true ] && [ "$controllerthree" -eq 4 ]; then
keystone user-role-add --user glance --tenant service --role admin || check=false

echo -------------------$filename line no : "$controllerthree"------------------------
#line no 4
((controllerthree=controllerthree+1))
fi


if [ "$check" = true ] && [ "$controllerthree" -eq 5 ]; then
keystone service-create --name glance --type image \
  --description "OpenStack Image Service" || check=false 
echo -------------------$filename line no : "$controllerthree"------------------------
#line no 5
((controllerthree=controllerthree+1))
fi


if [ "$check" = true ] && [ "$controllerthree" -eq 6 ]; then
keystone endpoint-create \
  --service-id $(keystone service-list | awk '/ image / {print $2}') \
  --publicurl http://$CONTROLLER_NODE_HOSTNAME:9292 \
  --internalurl http://$CONTROLLER_NODE_HOSTNAME:9292 \
  --adminurl http://$CONTROLLER_NODE_HOSTNAME:9292 \
  --region regionOne || check=false 
echo -------------------$filename line no : "$controllerthree"------------------------
#line no 6
((controllerthree=controllerthree+1))
fi

if [ "$check" = true ] && [ "$controllerthree" -eq 7 ]; then
sudo apt-get install glance python-glanceclient -y || check=false
echo -------------------$filename line no : "$controllerthree"------------------------
#line no 7
((controllerthree=controllerthree+1))
fi


if [ "$check" = true ] && [ "$controllerthree" -eq 8 ]; then
if [ -s ~/pullstack/autostack/conf/controller/glance-api.conf ]; then
sudo rm -rf /etc/glance/glance-api.conf
sudo cp ~/pullstack/autostack/conf/controller/glance-api.conf /etc/glance/ || check=false
else
echo --------------------------------------------------------------------------------
echo ----------- GLANCE API : /etc/glance/glance-api.conf  [ NOT EDITED ] -------------
echo -----------------------------------------------------------------------------------
fi
echo -------------------$filename line no : "$controllerthree"------------------------
#line no 8
((controllerthree=controllerthree+1))
fi


if [ "$check" = true ] && [ "$controllerthree" -eq 9 ]; then

if [ -s ~/pullstack/autostack/conf/controller/glance-registry.conf ]; then
sudo rm -rf /etc/glance/glance-registry.conf || check=false
sudo cp ~/pullstack/autostack/conf/controller/glance-registry.conf /etc/glance/ || check=false
else
echo --------------------------------------------------------------------------------
echo ----------- GLANCE REGISTRY : /etc/glance/glance-registry.conf  [ NOT EDITED ] -------------
echo -----------------------------------------------------------------------------------
fi 
echo -------------------$filename line no : "$controllerthree"------------------------
#line no 9
((controllerthree=controllerthree+1))
fi


if [ "$check" = true ] && [ "$controllerthree" -eq 10 ]; then
sudo su -s /bin/sh -c "glance-manage db_sync" glance || check=false
echo -------------------$filename line no : "$controllerthree"------------------------
#line no 10
((controllerthree=controllerthree+1))
fi

if [ "$check" = true ] && [ "$controllerthree" -eq 11 ]; then
sudo service glance-registry restart || check=false
sudo service glance-api restart || check=false
echo -------------------$filename line no : "$controllerthree"------------------------
#line no 11
((controllerthree=controllerthree+1))
fi

if [ "$check" = true ] && [ "$controllerthree" -eq 12 ]; then
sudo rm -f /var/lib/glance/glance.sqlite || check=false 
echo -------------------$filename line no : "$controllerthree"------------------------
#line no 12
((controllerthree=controllerthree+1))
fi


if [ "$check" = true ] && [ "$controllerthree" -eq 13 ]; then
echo ----------- VERIFYING  GLANCE ------------------------------
mkdir /tmp/images || check=false 
echo -------------------$filename line no : "$controllerthree"------------------------
#line no 13
((controllerthree=controllerthree+1))
fi

if [ "$check" = true ] && [ "$controllerthree" -eq 14 ]; then
wget -P /tmp/images http://download.cirros-cloud.net/0.3.3/cirros-0.3.3-x86_64-disk.img || check=false 
echo -------------------$filename line no : "$controllerthree"------------------------
#line no 14
((controllerthree=controllerthree+1))
fi


if [ "$check" = true ] && [ "$controllerthree" -eq 15 ]; then
source admin-openrc.sh || check=false 
echo -------------------$filename line no : "$controllerthree"------------------------
#line no 15
((controllerthree=controllerthree+1))
fi

if [ "$check" = true ] && [ "$controllerthree" -eq 16 ]; then
glance image-create --name "cirros-0.3.3-x86_64" --file /tmp/images/cirros-0.3.3-x86_64-disk.img \
  --disk-format qcow2 --container-format bare --is-public True --progress || check=false 
echo -------------------$filename line no : "$controllerthree"------------------------
#line no 16
((controllerthree=controllerthree+1))
fi

if [ "$check" = true ] && [ "$controllerthree" -eq 17 ];then
glance image-list || check=false 
echo -------------------$filename line no : "$controllerthree"------------------------
#line no 17
((controllerthree=controllerthree+1))
fi


if [ "$check" = true ] && [ "$controllerthree" -eq 18 ]; then
rm -r /tmp/images
echo -------------------$filename line no : "$controllerthree"------------------------
#line no 18
((controllerthree=controllerthree+1))


sed "s/controllerthree=.*/controllerthree="$controllerthree"/g" ~/pullstack/autostack/linecounterfiles/controller.properties > tmp
   mv tmp ~/pullstack/autostack/linecounterfiles/controller.properties
echo   -----------------------------------------------
echo \|  [ NOTE : This shell script executed Successfully . ] \|
echo   -----------------------------------------------

exit
#line no 19
((controllerthree=controllerthree+1))
fi
######################################################################################################


((controllerthree=controllerthree-1))

echo   ---------------------------------------------------------------------------------------------------------------------------------------------
echo \|  [ NOTE : Shell Script Execution Terminated at Line Number : "$controllerthree" , Verify this line and execute same shell script again and it will start there itself . ] \|
echo   ---------------------------------------------------------------------------------------------------------------------------------------------


sed "s/controllerthree=.*/controllerthree="$controllerthree"/g" ~/pullstack/autostack/linecounterfiles/controller.properties > tmp
   mv tmp ~/pullstack/autostack/linecounterfiles/controller.properties


fi
exit
