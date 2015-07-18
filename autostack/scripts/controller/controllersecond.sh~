#!/bin/bash


. ~/pullstack/autostack/linecounterfiles/controller.properties
. ~/pullstack/autostack/autostack.properties



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
if [ $controllertwo -eq 34 ]; then

#echo ---------------------------------------------------------
#echo \|   Manually Add Nameserver IP in- /etc/resolv.conf file- \|
#echo ---------------------------------------------------------

echo -----------------------------------------------------
echo \|   This Shell Script has been Executed Successfully. \|
echo -----------------------------------------------------

echo If you Want to execute it again Press [y/n] to Execute it.
read userchoice
     if [ "$userchoice" = "y" ]; then
     echo Enter Line Number you want to continue: [Valid 1 - 8] 
     echo And Execute it again.
     read againlinenumber

    sed "s/controllertwo=.*/controllertwo=$againlinenumber/g" ~/pullstack/autostack/linecounterfiles/controller.properties > tmp
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




if [ "$check" = true ] && [ $controllertwo -eq 1 ]; then

        if [ -s ~/pullstack/autostack/conf/common/resolv.conf ]; then
        sudo rm -rf /etc/resolv.conf || check=false
        fi
 
echo -------------------$filename line no : $controllertwo------------------------
#line no 1
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ $controllertwo -eq 2 ]; then
              if [ -s ~/pullstack/autostack/conf/common/resolv.conf ]; then
              sudo cp ~/pullstack/autostack/conf/common/resolv.conf /etc/ || check=false
              fi
echo -------------------$filename line no : $controllertwo------------------------
#line no 2
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ $controllertwo -eq 3 ]; then
if [ -s ~/pullstack/autostack/conf/common/hosts ]; then
sudo rm -rf  /etc/hosts || check=false 
fi

echo -------------------$filename line no : $controllertwo------------------------
#line no 3
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ $controllertwo -eq 4 ]; then
if [ -s ~/pullstack/autostack/conf/common/hosts ]; then
sudo cp ~/pullstack/autostack/conf/common/hosts /etc/ || check=false 
fi
echo -------------------$filename line no : $controllertwo------------------------
#line no 4
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ $controllertwo -eq 5 ]; then
sudo apt-get update && sudo apt-get update --fix-missing && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y || check=false 
echo -------------------$filename line no : $controllertwo------------------------
#line no 5
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ $controllertwo -eq 6 ]; then
sudo apt-get install ntp -y || check=false 
echo -------------------$filename line no : $controllertwo------------------------
#line no 6
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ $controllertwo -eq 7 ]; then
if [ -s ~/pullstack/autostack/conf/controller/ntp.conf ]; then
sudo rm -rf /etc/ntp.conf || check=false 
fi
echo -------------------$filename line no : $controllertwo------------------------
#line no 7
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ $controllertwo -eq 8 ]; then
if [ -s ~/pullstack/autostack/conf/controller/ntp.conf ]; then
sudo cp ~/pullstack/autostack/conf/controller/ntp.conf /etc/ || check=false 
fi
echo -------------------$filename line no : $controllertwo------------------------
#line no 8
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ $controllertwo -eq 9 ]; then
sudo rm -rf /var/lib/ntp/ntp.conf.dhcp || check=false 
echo -------------------$filename line no : $controllertwo------------------------
#line no 9
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ $controllertwo -eq 10 ]; then
sudo service ntp restart || check=false 
echo -------------------$filename line no : $controllertwo------------------------
#line no 10
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ $controllertwo -eq 11 ]; then
sshpass -p $ACCOUNT_PASSWORD ssh -o StrictHostKeyChecking=no $ACCOUNT_USERNAME@$NETWORK_NODE_PUBLIC_IP "sudo -u root ./networkntp.sh" || check=false 
echo -------------------$filename line no : $controllertwo------------------------
#line no 11
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ $controllertwo -eq 12 ]; then
sshpass -p $ACCOUNT_PASSWORD ssh -o StrictHostKeyChecking=no $ACCOUNT_USERNAME@$COMPUTE_NODE_PUBLIC_IP "sudo -u root ./computentp.sh" || check=false 
echo -------------------$filename line no : $controllertwo------------------------
#line no 12
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ $controllertwo -eq 13 ]; then

sudo ntpq -c peers || check=false 
echo -------------------$filename line no : $controllertwo------------------------
#line no 13
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ $controllertwo -eq 14 ]; then
sudo ntpq -c assoc || check=false 
echo -------------------$filename line no : $controllertwo------------------------
#line no 14
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ $controllertwo -eq 15 ]; then
sudo ntpq -c peers || check=false 
echo -------------------$filename line no : $controllertwo------------------------
#line no 15
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ $controllertwo -eq 16 ]; then
echo ntpc -c asoc at Network Node
sshpass -p $ACCOUNT_PASSWORD ssh -o StrictHostKeyChecking=no $ACCOUNT_USERNAME@$NETWORK_NODE_PUBLIC_IP "sudo -u root  ntpq -c assoc" || check=false 
echo -------------------$filename line no : $controllertwo------------------------
#line no 16
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ $controllertwo -eq 17 ]; then
#sudo rm -rf /etc/resolv.conf || check=false 
echo -------------------$filename line no : $controllertwo------------------------
#line no 17
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ $controllertwo -eq 18 ]; then
#sudo cp ~/pullstack/autostack/conf/common/resolv.conf /etc/ || check=false 
echo -------------------$filename line no : $controllertwo------------------------
#line no 18
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ $controllertwo -eq 19 ]; then
sudo apt-get install ubuntu-cloud-keyring || check=false 
echo -------------------$filename line no : $controllertwo------------------------
#line no 19
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ $controllertwo -eq 20 ]; then
sudo echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu" \
  "trusty-updates/juno main" > /etc/apt/sources.list.d/cloudarchive-juno.list || check=false

echo -------------------$filename line no : $controllertwo------------------------
#line no 20
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ $controllertwo -eq 21 ]; then
sudo apt-get update && sudo apt-get update --fix-missing && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y || check=false 
echo -------------------$filename line no : $controllertwo------------------------
#line no 21
((controllertwo=controllertwo+1))
fi



if [ "$check" = true ] && [ $controllertwo -eq 22 ]; then
sudo apt-get install mariadb-server python-mysqldb -y || check=false 
echo -------------------$filename line no : $controllertwo------------------------
#line no 22
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ $controllertwo -eq 23 ]; then
 if [ -s ~/pullstack/autostack/conf/controller/mariadb/my.cnf ]; then
sudo rm -rf /etc/mysql/my.cnf || check=false 
fi
echo -------------------$filename line no : $controllertwo------------------------
#line no 23
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ $controllertwo -eq 24 ]; then
if [ -s ~/pullstack/autostack/conf/controller/mariadb/my.cnf ]; then
sudo cp ~/pullstack/autostack/conf/controller/mariadb/my.cnf /etc/mysql/ || check=false
fi
echo -------------------$filename line no : $controllertwo------------------------
#line no 24
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ $controllertwo -eq 25 ]; then
#above copy is in controller in /freshcont/my.cnf

sudo service mysql restart || check=false
echo -------------------$filename line no : $controllertwo------------------------
#line no 25
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ $controllertwo -eq 26 ]; then
sudo apt-get install rabbitmq-server -y || check=false
echo -------------------$filename line no : $controllertwo------------------------
#line no 26
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ $controllertwo -eq 27 ]; then
sudo rabbitmqctl change_password guest $RABBIT_PASS || check=false
echo -------------------$filename line no : $controllertwo------------------------
#line no 27
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ $controllertwo -eq 28 ]; then
# $ACCOUNT_PASSWORD is password

echo ------------------------showing status of rabbit mysql------------------
sudo rabbitmqctl status | grep rabbit || check=false

echo -------------------$filename line no : $controllertwo------------------------
#line no 28
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ $controllertwo -eq 29 ]; then
if [ -s ~/pullstack/autostack/conf/controller/rabbitmq.config ]; then
sudo cp ~/pullstack/autostack/conf/controller/rabbitmq.config /etc/rabbitmq/ || check=false
fi
echo -------------------$filename line no : $controllertwo------------------------
#line no 29
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ $controllertwo -eq 30 ]; then
sudo service rabbitmq-server restart || check=false
echo -------------------$filename line no : $controllertwo------------------------
#line no 30
((controllertwo=controllertwo+1))
fi



if [ "$check" = true ] && [ $controllertwo -eq 31 ]; then
echo ==== CREATE DATABASE keystone ====
echo ==== GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' \
  IDENTIFIED BY 'KEYSTONE_DBPASS' ====
echo ==== GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' \
  IDENTIFIED BY 'KEYSTONE_DBPASS' ====
echo ==== exit ====
echo ====== Creating it automatically ========
####################################################################################

MYSQL=`which mysql`
 
Q1="CREATE DATABASE IF NOT EXISTS keystonerishi;"

Q2="GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' \
  IDENTIFIED BY '$KEYSTONE_DBPASS';"
Q3="GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' \
  IDENTIFIED BY '$KEYSTONE_DBPASS';"
Q4="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}${Q4}"
 

$MYSQL -uroot -p$DATABASE_PASSWORD -e "$SQL" || check=false

if [ "$check" = true ]; then
echo ------- Keystone Database is Created -------
fi

############################## keystone database created ##################################

echo -------------------$filename line no : $controllertwo------------------------
#line no 31
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ $controllertwo -eq 32 ]; then
sudo apt-get install keystone python-keystoneclient -y || check=false
echo -------------------$filename line no : $controllertwo------------------------
#line no 32
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ $controllertwo -eq 33 ]; then
echo ----------- Copy Below Admin Token ----------------------
ADMIN_TOKEN=$(openssl rand -hex 10) || check=false
replace "ADMIN_TOKEN" $ADMIN_TOKEN -- ~/pullstack/autostack/conf/controller/keystone.conf || check=false
echo -------------------$filename line no : $controllertwo------------------------
#line no 33
((controllertwo=controllertwo+1))


sed "s/controllertwo=.*/controllertwo=$controllertwo/g" ~/pullstack/autostack/linecounterfiles/controller.properties > tmp
   mv ~/pullstack/autostack/linecounterfiles/controller.properties

exit
fi


((controllertwo=controllertwo-1))

echo   ---------------------------------------------------------------------------------------------------------------------------------------------
echo \|  [ NOTE : Shell Script Execution Terminated at Line Number : $controllertwo , Verify this line and execute same shell script again and it will start there itself . ] \|
echo   ---------------------------------------------------------------------------------------------------------------------------------------------


sed "s/controllertwo=.*/controllertwo=$controllertwo/g" ~/pullstack/autostack/linecounterfiles/controller.properties > tmp
   mv ~/pullstack/autostack/linecounterfiles/controller.properties


fi
exit
