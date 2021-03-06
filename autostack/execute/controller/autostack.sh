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

	source=~/pullstack
	destination=/home/autostack/

	if [ ! -d "$destination" ]; then
	mkdir -p "$destination"
	fi
	sudo cp -R "$source" "$destination"
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
	if [ "$controllertwo" -eq 58 ]; then

	echo -----------------------------------------------------
	echo \|   This Shell Script has been Executed Successfully. \|
	echo -----------------------------------------------------

	echo If you Want to execute it again Press [y/n] to Execute it.
	read userchoice
	if [ "$userchoice" = "y" ]; then
	echo Enter Line Number you want to continue: [Valid 1 - 58] 
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



if [ "$check" = true ] && [ "$controllertwo" -eq 1 ]; then

if [ -s ~/pullstack/autostack/conf/common/resolv.conf ]; then
pwd
fi

echo -------------------$filename line no : "$controllertwo"------------------------
#line no 1
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 2 ]; then
if [ -s ~/pullstack/autostack/conf/common/resolv.conf ]; then
pwd
fi
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 2
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 3 ]; then
	if [ -s ~/pullstack/autostack/conf/common/hosts ]; then
	pwd
	fi

	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 3
((controllertwo=controllertwo+1))
	fi


	if [ "$check" = true ] && [ "$controllertwo" -eq 4 ]; then
	if [ -s ~/pullstack/autostack/conf/common/hosts ]; then
	pwd
	fi
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 4
((controllertwo=controllertwo+1))
	fi


	if [ "$check" = true ] && [ "$controllertwo" -eq 5 ]; then
	sudo apt-get update && sudo apt-get update --fix-missing && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y || check=false 
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 5
((controllertwo=controllertwo+1))
	fi


	if [ "$check" = true ] && [ "$controllertwo" -eq 6 ]; then
	sudo apt-get install ntp -y || check=false 
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 6
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 7 ]; then
	if [ -s ~/pullstack/autostack/conf/controller/ntp.conf ]; then
	sudo rm -rf /etc/ntp.conf || check=false 
	fi
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 7
((controllertwo=controllertwo+1))
	fi


	if [ "$check" = true ] && [ "$controllertwo" -eq 8 ]; then
	if [ -s ~/pullstack/autostack/conf/controller/ntp.conf ]; then
	sudo cp ~/pullstack/autostack/conf/controller/ntp.conf /etc/ || check=false 
	fi
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 8
((controllertwo=controllertwo+1))
	fi


	if [ "$check" = true ] && [ "$controllertwo" -eq 9 ]; then
	sudo rm -rf /var/lib/ntp/ntp.conf.dhcp || check=false 
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 9
((controllertwo=controllertwo+1))
	fi


	if [ "$check" = true ] && [ "$controllertwo" -eq 10 ]; then
	sudo service ntp restart || check=false 
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 10
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 11 ]; then
sshpass -p $ACCOUNT_PASSWORD ssh -o StrictHostKeyChecking=no $ACCOUNT_USERNAME@$NETWORK_NODE_PUBLIC_IP "sudo -u root ./networkntp.sh" || check=false 

	pwd
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 11
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 12 ]; then
sshpass -p $ACCOUNT_PASSWORD ssh -o StrictHostKeyChecking=no $ACCOUNT_USERNAME@$COMPUTE_NODE_PUBLIC_IP "sudo -u root ./computentp.sh" || check=false 
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 12
((controllertwo=controllertwo+1))
	fi


	if [ "$check" = true ] && [ "$controllertwo" -eq 13 ]; then

	sudo ntpq -c peers || check=false 
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 13
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 14 ]; then
	sudo ntpq -c assoc || check=false 
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 14
((controllertwo=controllertwo+1))
	fi


	if [ "$check" = true ] && [ "$controllertwo" -eq 15 ]; then
	sudo ntpq -c peers || check=false 
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 15
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 16 ]; then
	echo ntpc -c asoc at Network Node
sshpass -p $ACCOUNT_PASSWORD ssh -o StrictHostKeyChecking=no $ACCOUNT_USERNAME@$NETWORK_NODE_PUBLIC_IP "sudo -u root  ntpq -c assoc" || check=false 
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 16
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 17 ];then
#sudo rm -rf /etc/resolv.conf || check=false 
	pwd
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 17
((controllertwo=controllertwo+1))
	fi


	if [ "$check" = true ] && [ "$controllertwo" -eq 18 ]; then
#sudo cp ~/pullstack/autostack/conf/common/resolv.conf /etc/ || check=false 
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 18
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 19 ]; then
	sudo apt-get install ubuntu-cloud-keyring || check=false 
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 19
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 20 ]; then
echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu" \
  "trusty-updates/juno main" > /etc/apt/sources.list.d/cloudarchive-juno.list || check=false

		echo -------------------$filename line no : "$controllertwo"------------------------
#line no 20
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 21 ]; then
	sudo apt-get update && sudo apt-get update --fix-missing && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y || check=false 
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 21
((controllertwo=controllertwo+1))
	fi



	if [ "$check" = true ] && [ "$controllertwo" -eq 22 ]; then
	sudo apt-get install mariadb-server python-mysqldb -y || check=false 
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 22
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 23 ]; then
	if [ -s ~/pullstack/autostack/conf/controller/mariadb/my.cnf ]; then
	sudo rm -rf /etc/mysql/my.cnf || check=false 
	fi
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 23
((controllertwo=controllertwo+1))
	fi


	if [ "$check" = true ] && [ "$controllertwo" -eq 24 ]; then
	if [ -s ~/pullstack/autostack/conf/controller/mariadb/my.cnf ]; then
	sudo cp ~/pullstack/autostack/conf/controller/mariadb/my.cnf /etc/mysql/ || check=false
	fi
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 24
((controllertwo=controllertwo+1))
	fi


	if [ "$check" = true ] && [ "$controllertwo" -eq 25 ]; then
#above copy is in controller in /freshcont/my.cnf

	sudo service mysql restart || check=false
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 25
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 26 ]; then
	sudo apt-get install rabbitmq-server -y || check=false
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 26
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 27 ]; then
	sudo rabbitmqctl change_password guest $RABBIT_PASS || check=false
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 27
((controllertwo=controllertwo+1))
	fi


	if [ "$check" = true ] && [ "$controllertwo" -eq 28 ]; then
# $ACCOUNT_PASSWORD is password

	echo ------------------------showing status of rabbit mysql------------------
	sudo rabbitmqctl status | grep rabbit || check=false

	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 28
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 29 ]; then
	if [ -s ~/pullstack/autostack/conf/controller/rabbitmq.config ]; then
	sudo cp ~/pullstack/autostack/conf/controller/rabbitmq.config /etc/rabbitmq/ || check=false
	fi
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 29
((controllertwo=controllertwo+1))
	fi


	if [ "$check" = true ] && [ "$controllertwo" -eq 30 ]; then
	sudo service rabbitmq-server restart || check=false
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 30
((controllertwo=controllertwo+1))
	fi



	if [ "$check" = true ] && [ "$controllertwo" -eq 31 ]; then
	echo ==== CREATE DATABASE keystone ====
		    echo ====== Creating it automatically ========
####################################################################################

		    MYSQL=`which mysql`

		    Q1="CREATE DATABASE IF NOT EXISTS keystone;"

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

			    echo -------------------$filename line no : "$controllertwo"------------------------
#line no 31
((controllertwo=controllertwo+1))
	fi


	if [ "$check" = true ] && [ "$controllertwo" -eq 32 ]; then
	sudo apt-get install keystone python-keystoneclient -y || check=false
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 32
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 33 ]; then
	echo ----------- Copy Below Admin Token ----------------------
	ADMIN_TOKEN=$(openssl rand -hex 10) || check=false
	sed -i -e "s/ADMIN_TOKEN/$ADMIN_TOKEN/g" ~/pullstack/autostack/conf/controller/keystone.conf || check=false
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 33
((controllertwo=controllertwo+1))

	fi

###########################################################################################################33

	if [ "$check" = true ] && [ "$controllertwo" -eq 34 ]; then
	if [ -s ~/pullstack/autostack/controller/keystone.conf ]; then
	sudo rm -rf /etc/keystone/keystone.conf || check=false
	sudo cp ~/pullstack/autostack/controller/keystone.conf /etc/keystone/ || check=false
	fi
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 34
((controllertwo=controllertwo+1))
	fi


	if [ "$check" = true ] && [ "$controllertwo" -eq 35 ]; then
	su -s /bin/sh -c "keystone-manage db_sync" keystone || check=false
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 35
((controllertwo=controllertwo+1))
	fi


	if [ "$check" = true ] && [ "$controllertwo" -eq 36 ]; then
	service keystone restart || check=false
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 36
((controllertwo=controllertwo+1))
	fi


	if [ "$check" = true ] && [ "$controllertwo" -eq 37 ]; then
	sudo rm -f /var/lib/keystone/keystone.db || check=false
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 37
((controllertwo=controllertwo+1))
	fi


	if [ "$check" = true ] && [ "$controllertwo" -eq 38 ]; then
	(crontab -l -u keystone 2>&1 | grep -q token_flush) || \
		echo '@hourly /usr/bin/keystone-manage token_flush >/var/log/keystone/keystone-tokenflush.log 2>&1' \
		>> /var/spool/cron/crontabs/keystone || check=false
		echo -------------------$filename line no : "$controllertwo"------------------------
#line no 38
((controllertwo=controllertwo+1))
	fi


	if [ "$check" = true ] && [ "$controllertwo" -eq 39 ]; then
	export OS_SERVICE_TOKEN=$ADMIN_TOKEN || check=false
	export OS_SERVICE_ENDPOINT=http://$CONTROLLER_NODE_HOSTNAME:35357/v2.0 || check=false
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 39
((controllertwo=controllertwo+1))
	fi



	if [ "$check" = true ] && [ "$controllertwo" -eq 40 ]; then
	keystone tenant-create --name admin --description "Admin Tenant" || check=false
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 40
((controllertwo=controllertwo+1))
	fi


	if [ "$check" = true ] && [ "$controllertwo" -eq 41 ]; then
	keystone user-create --name admin --pass $ADMIN_PASS --email $ADMIN_EMAIL_ADDRESS || check=false
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 41
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 42 ]; then
	keystone role-create --name admin || check=false
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 42
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 43 ]; then
	keystone user-role-add --user admin --tenant admin --role admin || check=false
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 43
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 44 ]; then
	keystone tenant-create --name demo --description "Demo Tenant" || check=false
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 44
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 45 ]; then
	keystone user-create --name demo --tenant demo --pass $DEMO_PASS --email $DEMO_EMAIL_ADDRESS || check=false
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 45
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 46 ]; then
	keystone tenant-create --name service --description "Service Tenant" || check=false
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 46
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 47 ]; then
	export OS_SERVICE_TOKEN=$ADMIN_TOKEN || check=false
	export OS_SERVICE_ENDPOINT=http://$CONTROLLER_NODE_HOSTNAME:35357/v2.0 || check=false || check=false
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 47
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 48 ]; then
	keystone service-create --name keystone --type identity \
		--description "OpenStack Identity" || check=false
		echo -------------------$filename line no : "$controllertwo"------------------------
#line no 48
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 49 ]; then
	keystone endpoint-create \
		--service-id $(keystone service-list | awk '/ identity / {print $2}') \
		--publicurl http://$CONTROLLER_NODE_HOSTNAME:5000/v2.0 \
		--internalurl http://$CONTROLLER_NODE_HOSTNAME:5000/v2.0 \ source admin-openrc.sh
		--adminurl http://$CONTROLLER_NODE_HOSTNAME:35357/v2.0 \
			--region regionOne || check=false || check=false
			echo -------------------$filename line no : "$controllertwo"------------------------
#line no 49
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 50 ]; then
	echo -------------------------------------------------------------------------------------------------------------------------------
	echo ------------------------------------------  VERIFYING  IDENTITY  SERVICE  -----------------------------------------------------
	echo -------------------------------------------------------------------------------------------------------------------------------
	unset OS_SERVICE_TOKEN OS_SERVICE_ENDPOINT || check=false
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 50
((controllertwo=controllertwo+1))
	fi


	if [ "$check" = true ] && [ "$controllertwo" -eq 51 ]; then
         pwd	
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 51
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 52 ]; then
	keystone --os-tenant-name admin --os-username admin --os-password $ADMIN_PASS \
		--os-auth-url http://$CONTROLLER_NODE_HOSTNAME:35357/v2.0 token-get || check=false
		echo -------------------$filename line no : "$controllertwo"------------------------
#line no 52
((controllertwo=controllertwo+1))
	fi


	if [ "$check" = true ] && [ "$controllertwo" -eq 53 ]; then
	keystone --os-tenant-name admin --os-username admin --os-password $ADMIN_PASS \
		--os-auth-url http://$CONTROLLER_NODE_HOSTNAME:35357/v2.0 tenant-list || check=false
		echo -------------------$filename line no : "$controllertwo"------------------------
#line no 53
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 54 ]; then
	keystone --os-tenant-name admin --os-username admin --os-password $ADMIN_PASS \
		--os-auth-url http://$CONTROLLER_NODE_HOSTNAME:35357/v2.0 user-list || check=false
		echo -------------------$filename line no : "$controllertwo"------------------------
#line no 54
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 55 ]; then
	keystone --os-tenant-name admin --os-username admin --os-password $ADMIN_PASS \
		--os-auth-url http://$CONTROLLER_NODE_HOSTNAME:35357/v2.0 role-list || check=false
		echo -------------------$filename line no : "$controllertwo"------------------------
#line no 55
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 56 ]; then
	keystone --os-tenant-name demo --os-username demo --os-password $DEMO_PASS \
		--os-auth-url http://$CONTROLLER_NODE_HOSTNAME:35357/v2.0 token-get || check=false
		echo -------------------$filename line no : "$controllertwo"------------------------
#line no 56
((controllertwo=controllertwo+1))
	fi


	if [ "$check" = true ] && [ "$controllertwo" -eq 57 ]; then
	keystone --os-tenant-name demo --os-username demo --os-password $DEMO_PASS \
		--os-auth-url http://$CONTROLLER_NODE_HOSTNAME:35357/v2.0 user-list
		echo -------------------$filename line no : "$controllertwo"------------------------
#line no 57
((controllertwo=controllertwo+1))
	fi

#---------------------------------------------------------------------- ABOVE THIS ------------------------------------------------------------------



#---- CONTROLLER 3 ------ START ----



if [ "$check" = true ] && [ "$controllertwo" -eq 58 ]; then

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

echo -------------------$filename line no : "$controllertwo"------------------------
#line no 58
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 59 ]; then
source admin-openrc.sh || check=false 
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 59
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 60 ]; then
keystone user-create --name glance --pass $GLANCE_PASS || check=false 

echo -------------------$filename line no : "$controllertwo"------------------------
#line no 60
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 61 ]; then
keystone user-role-add --user glance --tenant service --role admin || check=false

echo -------------------$filename line no : "$controllertwo"------------------------
#line no 61
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 62 ]; then
keystone service-create --name glance --type image \
  --description "OpenStack Image Service" || check=false 
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 62
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 63 ]; then
keystone endpoint-create \
  --service-id $(keystone service-list | awk '/ image / {print $2}') \
  --publicurl http://$CONTROLLER_NODE_HOSTNAME:9292 \
  --internalurl http://$CONTROLLER_NODE_HOSTNAME:9292 \
  --adminurl http://$CONTROLLER_NODE_HOSTNAME:9292 \
  --region regionOne || check=false 
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 63
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ "$controllertwo" -eq 64 ]; then
sudo apt-get install glance python-glanceclient -y || check=false
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 64
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 65 ]; then
if [ -s ~/pullstack/autostack/conf/controller/glance-api.conf ]; then
sudo rm -rf /etc/glance/glance-api.conf
sudo cp ~/pullstack/autostack/conf/controller/glance-api.conf /etc/glance/ || check=false
else
echo --------------------------------------------------------------------------------
echo ----------- GLANCE API : /etc/glance/glance-api.conf  [ NOT EDITED ] -------------
echo -----------------------------------------------------------------------------------
fi
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 65
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 66 ]; then

if [ -s ~/pullstack/autostack/conf/controller/glance-registry.conf ]; then
sudo rm -rf /etc/glance/glance-registry.conf || check=false
sudo cp ~/pullstack/autostack/conf/controller/glance-registry.conf /etc/glance/ || check=false
else
echo --------------------------------------------------------------------------------
echo ----------- GLANCE REGISTRY : /etc/glance/glance-registry.conf  [ NOT EDITED ] -------------
echo -----------------------------------------------------------------------------------
fi 
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 66
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 67 ]; then
su -s /bin/sh -c "glance-manage db_sync" glance || check=false
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 67
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ "$controllertwo" -eq 68 ]; then
sudo service glance-registry restart || check=false
sudo service glance-api restart || check=false
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 68
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ "$controllertwo" -eq 69 ]; then
sudo rm -f /var/lib/glance/glance.sqlite || check=false 
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 69
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 70 ]; then
echo ----------- VERIFYING  GLANCE ------------------------------
mkdir /tmp/images || check=false 
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 70
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ "$controllertwo" -eq 71 ]; then
wget -P /tmp/images http://download.cirros-cloud.net/0.3.3/cirros-0.3.3-x86_64-disk.img || check=false 
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 71
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 72 ]; then
source admin-openrc.sh || check=false 
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 72
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ "$controllertwo" -eq 73 ]; then
glance image-create --name "cirros-0.3.3-x86_64" --file /tmp/images/cirros-0.3.3-x86_64-disk.img \
  --disk-format qcow2 --container-format bare --is-public True --progress || check=false 
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 73
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ "$controllertwo" -eq 74 ];then
glance image-list || check=false 
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 74
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 75 ]; then
rm -r /tmp/images
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 75
((controllertwo=controllertwo+1))

fi

#---- CONTROLLER 3 ------- ENDS -----

#---- CONTROLLER 4 ------- STARTS -----




if [ "$check" = true ] && [ "$controllertwo" -eq 76 ]; then

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
echo ------- Nova Database is Created -------
fi

############################## keystone database created ##################################

echo -------------------$filename line no : "$controllertwo"------------------------
#line no 76
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 77 ]; then
source admin-openrc.sh || check=false 
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 77
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 78 ]; then
keystone user-create --name nova --pass $NOVA_PASS || check=false 

echo -------------------$filename line no : "$controllertwo"------------------------
#line no 78
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 79 ]; then
keystone user-role-add --user nova --tenant service --role admin || check=false

echo -------------------$filename line no : "$controllertwo"------------------------
#line no 79
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 80 ]; then
keystone service-create --name nova --type compute \
  --description "OpenStack Compute" || check=false 
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 80
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 81 ]; then

keystone endpoint-create \
  --service-id $(keystone service-list | awk '/ compute / {print $2}') \
  --publicurl http://$CONTROLLER_NODE_HOSTNAME:8774/v2/%\(tenant_id\)s \
  --internalurl http://$CONTROLLER_NODE_HOSTNAME:8774/v2/%\(tenant_id\)s \
  --adminurl http://$CONTROLLER_NODE_HOSTNAME:8774/v2/%\(tenant_id\)s \
  --region regionOne || check=false
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 81


((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ "$controllertwo" -eq 82 ]; then
sudo apt-get install nova-api nova-cert nova-conductor nova-consoleauth \
  nova-novncproxy nova-scheduler python-novaclient -y || check=false
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 82
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 83 ]; then
if [ -s ~/pullstack/autostack/conf/controller/nova.conf ]; then
sudo rm -rf /etc/nova/nova.conf || check=false
sudo cp ~/pullstack/autostack/conf/controller/nova.conf /etc/nova/ || check=false
else
echo --------------------------------------------------------------------------------
echo ----------- NOVA : /etc/nova/nova.conf  [ NOT EDITED ] -------------
echo -----------------------------------------------------------------------------------
fi
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 83
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 84 ]; then
su -s /bin/sh -c "nova-manage db sync" nova || check=false
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 84
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ "$controllertwo" -eq 85 ]; then
sudo service nova-api restart || check=false
sudo service nova-cert restart || check=false
sudo service nova-consoleauth restart || check=false
sudo service nova-scheduler restart || check=false
sudo service nova-conductor restart || check=false
sudo service nova-novncproxy restart || check=false
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 85
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ "$controllertwo" -eq 86 ]; then
sudo rm -f /var/lib/nova/nova.sqlite || check=false 
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 86
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ "$controllertwo" -eq 87 ]; then
echo -------- NOVA ON COMPUTE [GOING TO COMPUTE NODE] -----------
sshpass -p $ACCOUNT_PASSWORD ssh -o StrictHostKeyChecking=no $ACCOUNT_USERNAME@$COMPUTE_NODE_PUBLIC_IP "sudo -u root ./computenova.sh" || check=false 
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 87
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 88 ]; then
echo ----------- VERIFYING  NOVA ------------------------------
source admin-openrc.sh || check=false
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 88
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ "$controllertwo" -eq 89 ]; then
echo NOVA SERVICE_LIST
echo [ It Should contain 4 controller services and 1 compute services ]
nova service-list || check=false 
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 89
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 90 ]; then
echo NOVA IMAGE-LIST
nova image-list || check=false 
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 90
((controllertwo=controllertwo+1))

fi

#---- CONTROLLER 4 ------- ENDS -----


#---- CONTROLLER 5 ------- STARTS -----



if [ "$check" = true ] && [ "$controllertwo" -eq 91 ]; then

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
echo ------- Neutron Database is Created -------
fi

############################## keystone database created ##################################

echo ------------------"$filename" line no : "$controllertwo"------------------------
#line no 91
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 92 ]; then
source admin-openrc.sh || check=false 
echo ------------------"$filename" line no : "$controllertwo"------------------------
#line no 92
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 93 ]; then
keystone user-create --name neutron --pass $NEUTRON_PASS || check=false 

echo ------------------"$filename" line no : "$controllertwo"------------------------
#line no 93
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 94 ]; then
keystone user-role-add --user neutron --tenant service --role admin || check=false

echo ------------------"$filename" line no : "$controllertwo"------------------------
#line no 94
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 95 ]; then
keystone service-create --name neutron --type network \
  --description "OpenStack Networking" || check=false 
echo ------------------"$filename" line no : "$controllertwo"------------------------
#line no 95
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 96 ]; then

keystone endpoint-create \
  --service-id $(keystone service-list | awk '/ network / {print $2}') \
  --publicurl http://$CONTROLLER_NODE_HOSTNAME:9696 \
  --adminurl http://$CONTROLLER_NODE_HOSTNAME:9696 \
  --internalurl http://$CONTROLLER_NODE_HOSTNAME:9696 \
  --region regionOne
echo ------------------"$filename" line no : "$controllertwo"------------------------
#line no 96
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ "$controllertwo" -eq 97 ]; then
sudo apt-get install neutron-server neutron-plugin-ml2 python-neutronclient -y || check=false
echo ------------------"$filename" line no : "$controllertwo"------------------------
#line no 97
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 98 ]; then

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
echo ------------------"$filename" line no : "$controllertwo"------------------------
#line no 98
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 99 ]; then

if [ -s ~/pullstack/autostack/conf/controller/ml2_conf.ini ]; then
sudo rm -rf /etc/neutron/plugins/ml2/ml2_conf.ini || check=false
sudo cp ~/pullstack/autostack/conf/controller/ml2_conf.ini /etc/neutron/plugins/ml2/ || check=false
else
echo --------------------------------------------------------------------------------
echo ----------- NEUTRON : /etc/neutron/plugins/ml2/ml2_conf.ini  [ NOT EDITED ] -------------
echo -----------------------------------------------------------------------------------
fi
echo ------------------"$filename" line no : "$controllertwo"------------------------
#line no 99
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 100 ]; then

if [ -s ~/pullstack/autostack/conf/controller/network_nova/nova.conf ]; then
sudo rm -rf /etc/nova/nova.conf || check=false
sudo cp ~/pullstack/autostack/conf/controller/network_nova/nova.conf /etc/nova/ || check=false
else
echo --------------------------------------------------------------------------------
echo ----------- NEUTRON-NOVA [controller] : /etc/nova/nova.conf  [ NOT EDITED ] -------------
echo -----------------------------------------------------------------------------------
fi
echo ------------------"$filename" line no : "$controllertwo"------------------------
#line no 100
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ "$controllertwo" -eq 101 ]; then
su -s /bin/sh -c "neutron-db-manage --config-file /etc/neutron/neutron.conf \
  --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade juno" neutron || check=false
echo ------------------"$filename" line no : "$controllertwo"------------------------
#line no 101
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 102 ]; then
sudo service nova-api restart || check=false
sudo service nova-cert restart || check=false
sudo service nova-consoleauth restart || check=false
sudo service nova-scheduler restart || check=false
sudo service nova-conductor restart || check=false
sudo service nova-novncproxy restart || check=false
sudo service neutron-server restart || check=false
echo ------------------"$filename" line no : "$controllertwo"------------------------
#line no 102
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ "$controllertwo" -eq 103 ]; then
source admin-openrc.sh || check=false
neutron ext-list || check=false
echo ------------------"$filename" line no : "$controllertwo"------------------------
#line no 103
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ "$controllertwo" -eq 104 ]; then
echo ---======---  Installing NETWORK Services - Network Node ---======---
echo --- Going To Network Node ---
sshpass -p $ACCOUNT_PASSWORD ssh -o StrictHostKeyChecking=no $ACCOUNT_USERNAME@$NETWORK_NODE_PUBLIC_IP "sudo -u root ./networknetwork.sh" || check=false
echo ------------------"$filename" line no : "$controllertwo"------------------------
#line no 104
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 105 ]; then

if [ -s ~/pullstack/autostack/conf/controller/network_nova/netwotk_network_nova/nova.conf ]; then
sudo rm -rf /etc/nova/nova.conf || check=false
sudo cp ~/pullstack/autostack/conf/controller/network_nova/netwotk_network_nova/nova.conf /etc/nova/ || check=false
sudo service nova-api restart || check=false
else
echo --------------------------------------------------------------------------------
echo ----------- NEUTRON-NOVA [network on controller] : /etc/nova/nova.conf  [ NOT EDITED ] -------------
echo -----------------------------------------------------------------------------------
fi
echo ------------------"$filename" line no : "$controllertwo"------------------------
#line no 105
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ "$controllertwo" -eq 106 ]; then
echo -------- NOVA ON COMPUTE [GOING TO COMPUTE NODE] -----------

sshpass -p $ACCOUNT_PASSWORD ssh -o StrictHostKeyChecking=no $ACCOUNT_USERNAME@$NETWORK_NODE_PUBLIC_IP "sudo -u root ./networknetworksecond.sh" || check=false
echo ------------------"$filename" line no : "$controllertwo"------------------------
#line no 106
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 107 ]; then
echo ----------  "Verifying Operation - NETWORK [Network] SERVICE" ----------
source admin-openrc.sh || check=false
neutron agent-list || check=false
echo   -----------------------------------------------
echo \|  [ NOTE : It Should contain 4 Network Services. . ] \|
echo   -----------------------------------------------

echo ------------------"$filename" line no : "$controllertwo"------------------------
#line no 107
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ "$controllertwo" -eq 108 ]; then
echo ---======---  Installing NETWORK Services - Compute Node ---======---
echo --- Going To Compute Node ---
sshpass -p $ACCOUNT_PASSWORD ssh -o StrictHostKeyChecking=no $ACCOUNT_USERNAME@$COMPUTE_NODE_PUBLIC_IP "sudo -u root ./computenetwork.sh" || check=false
echo ------------------"$filename" line no : "$controllertwo"------------------------
#line no 108
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 109 ]; then
echo ------------  "Verifying Operation - NETWORK [Compute] SERVICE" ------------
source admin-openrc.sh || check=false
neutron agent-list || check=false
echo   ------------------------------------------------------
echo \|  [ NOTE : It Should contain Compute Open vSwitch agent. . ] \|
echo   ------------------------------------------------------

echo ------------------"$filename" line no : "$controllertwo"------------------------
#line no 109
((controllertwo=controllertwo+1))
fi
#---- CONTROLLER 5 ------- ENDS -----


#---- CONTROLLER 6 ------- STARTS -----




if [ "$check" = true ] && [ "$controllertwo" -eq 110 ]; then
source admin-openrc.sh || check=false 
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 110
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 111 ]; then
source admin-openrc.sh || check=false
neutron net-create ext-net --router:external True \
  --provider:physical_network external --provider:network_type flat
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 111
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 112 ]; then
neutron subnet-create ext-net --name ext-subnet \
  --allocation-pool start=$FLOATING_IP_START,end=$FLOATING_IP_END \
  --disable-dhcp --gateway $EXTERNAL_NETWORK_GATEWAY $EXTERNAL_NETWORK_CIDR || check=false 

echo -------------------$filename line no : "$controllertwo"------------------------
#line no 112
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 113 ]; then
neutron net-create admin-net

echo -------------------$filename line no : "$controllertwo"------------------------
#line no 113
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 114 ]; then
neutron subnet-create admin-net --name admin-subnet \
  --gateway $TENANT_NETWORK_GATEWAY $TENANT_NETWORK_CIDR
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 114
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 115 ]; then

neutron router-create admin-router
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 115
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ "$controllertwo" -eq 116 ]; then
neutron router-interface-add admin-router admin-subnet
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 116
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 117 ]; then
neutron router-gateway-set admin-router ext-net
echo --------------------------------------------
echo It will show : Set gateway -- router admin-router
echo --------------------------------------------
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 117
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 118 ]; then
source demo-openrc.sh || check=false
neutron net-create demo-net || check=false
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 118
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ "$controllertwo" -eq 119 ]; then
neutron subnet-create demo-net --name demo-subnet \
  --gateway $TENANT_NETWORK_GATEWAY $TENANT_NETWORK_CIDR || check=false
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 119
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ "$controllertwo" -eq 120 ]; then
neutron router-create demo-router || check=false 
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 120
((controllertwo=controllertwo+1))
fi

if [ "$check" = true ] && [ "$controllertwo" -eq 121 ]; then
neutron router-interface-add demo-router demo-subnet || check=false
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 121
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 122 ]; then
neutron router-gateway-set demo-router ext-net || check=false
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 122
((controllertwo=controllertwo+1))
fi

#---- CONTROLLER 6 ------- ENDS -----

#---- CONTROLLER 7 ------- STARTS -----




if [ "$check" = true ] && [ "$controllertwo" -eq 123 ]; then
sudo apt-get install openstack-dashboard apache2 libapache2-mod-wsgi memcached python-memcache -y || check=false 
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 123
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 124 ]; then


if [ -s ~/pullstack/autostack/conf/controller/local_settings.py ]; then
sudo rm -rf /etc/openstack-dashboard/local_settings.py || check=false
sudo cp ~/pullstack/autostack/conf/controller/local_settings.py /etc/openstack-dashboard/ || check=false
else
echo --------------------------------------------------------------------------------
echo ----------- DASHBOARD [controller] : /etc/openstack-dashboard/local_settings.py  [ NOT EDITED ] -------------
echo -----------------------------------------------------------------------------------
fi

echo -------------------$filename line no : "$controllertwo"------------------------
#line no 124
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 125 ]; then
sudo service apache2 restart
sudo service memcached restart

echo ***************** DASHBOARD INSTALLED SUCCESSFULLY ******************

echo -------------------$filename line no : "$controllertwo"------------------------
#line no 125
((controllertwo=controllertwo+1))

	echo   ----------------------------------------------
	echo \|  [ NOTE : This Shell Script executed successfully . ] \|
	echo   ----------------------------------------------


	sed "s/controllertwo=.*/controllertwo="$controllertwo"/g" ~/pullstack/autostack/linecounterfiles/controller.properties > tmp
	mv tmp ~/pullstack/autostack/linecounterfiles/controller.properties

exit

fi


#---- CONTROLLER 7 ------- ENDS -----

#---------------------------------------------------------------------- ABOVE THIS ------------------------------------------------------------------

((controllertwo=controllertwo-1))

	echo   ---------------------------------------------------------------------------------------------------------------------------------------------
	echo \|  [ NOTE : Shell Script Execution Terminated at Line Number : "$controllertwo" , Verify this line and execute same shell script again and it will start there itself . ] \|
	echo   ---------------------------------------------------------------------------------------------------------------------------------------------


	sed "s/controllertwo=.*/controllertwo="$controllertwo"/g" ~/pullstack/autostack/linecounterfiles/controller.properties > tmp
	mv tmp ~/pullstack/autostack/linecounterfiles/controller.properties


	fi
	exit
