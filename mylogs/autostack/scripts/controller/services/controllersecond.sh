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
sudo rm -rf /etc/resolv.conf || check=false
fi

echo -------------------$filename line no : "$controllertwo"------------------------
#line no 1
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 2 ]; then
if [ -s ~/pullstack/autostack/conf/common/resolv.conf ]; then
sudo cp ~/pullstack/autostack/conf/common/resolv.conf /etc/ || check=false
fi
echo -------------------$filename line no : "$controllertwo"------------------------
#line no 2
((controllertwo=controllertwo+1))
fi


if [ "$check" = true ] && [ "$controllertwo" -eq 3 ]; then
	if [ -s ~/pullstack/autostack/conf/common/hosts ]; then
	sudo rm -rf  /etc/hosts || check=false 
	fi

	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 3
((controllertwo=controllertwo+1))
	fi


	if [ "$check" = true ] && [ "$controllertwo" -eq 4 ]; then
	if [ -s ~/pullstack/autostack/conf/common/hosts ]; then
	sudo cp ~/pullstack/autostack/conf/common/hosts /etc/ || check=false 
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
#sshpass -p $ACCOUNT_PASSWORD ssh -o StrictHostKeyChecking=no $ACCOUNT_USERNAME@$NETWORK_NODE_PUBLIC_IP "sudo -u root ./networkntp.sh" || check=false 

	pwd
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 11
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 12 ]; then
#sshpass -p $ACCOUNT_PASSWORD ssh -o StrictHostKeyChecking=no $ACCOUNT_USERNAME@$COMPUTE_NODE_PUBLIC_IP "sudo -u root ./computentp.sh" || check=false 
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
#sshpass -p $ACCOUNT_PASSWORD ssh -o StrictHostKeyChecking=no $ACCOUNT_USERNAME@$NETWORK_NODE_PUBLIC_IP "sudo -u root  ntpq -c assoc" || check=false 
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 16
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 17 ];
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
	sudo echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu" \
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
	echo ==== GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' \
	      IDENTIFIED BY 'KEYSTONE_DBPASS' ====
	      echo ==== GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' \
		    IDENTIFIED BY 'KEYSTONE_DBPASS' ====
		    echo ==== exit ====
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
#replace "ADMIN_TOKEN" $ADMIN_TOKEN -- ~/pullstack/autostack/conf/controller/keystone.conf || check=false

	sudo sed -i -e "s/ADMIN_TOKEN/$ADMIN_TOKEN/g" ~/pullstack/autostack/conf/controller/keystone.conf || check=false
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
	sudo su -s /bin/sh -c "keystone-manage db_sync" keystone || check=false
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 35
((controllertwo=controllertwo+1))
	fi


	if [ "$check" = true ] && [ "$controllertwo" -eq 36 ]; then
	sudo service keystone restart || check=false
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
	sudo keystone tenant-create --name admin --description "Admin Tenant" || check=false
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 40
((controllertwo=controllertwo+1))
	fi


	if [ "$check" = true ] && [ "$controllertwo" -eq 41 ]; then
	sudo keystone user-create --name admin --pass $ADMIN_PASS --email $ADMIN_EMAIL_ADDRESS || check=false
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
	sudo keystone user-create --name demo --tenant demo --pass $DEMO_PASS --email $DEMO_EMAIL_ADDRESS || check=false
	echo -------------------$filename line no : "$controllertwo"------------------------
#line no 45
((controllertwo=controllertwo+1))
	fi

	if [ "$check" = true ] && [ "$controllertwo" -eq 46 ]; then
	sudo keystone tenant-create --name service --description "Service Tenant" || check=false
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
	sudo keystone service-create --name keystone --type identity \
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


((controllertwo=controllertwo+1))


	sed "s/controllertwo=.*/controllertwo="$controllertwo"/g" ~/pullstack/autostack/linecounterfiles/controller.properties > tmp
	mv tmp ~/pullstack/autostack/linecounterfiles/controller.properties
	echo   -----------------------------------------------
	echo \|  [ NOTE : This shell script executed Successfully . ] \|
	echo   -----------------------------------------------


	exit
#line no 57
((controllertwo=controllertwo+1))
	fi
######################################################################################################


((controllertwo=controllertwo-1))

	echo   ---------------------------------------------------------------------------------------------------------------------------------------------
	echo \|  [ NOTE : Shell Script Execution Terminated at Line Number : "$controllertwo" , Verify this line and execute same shell script again and it will start there itself . ] \|
	echo   ---------------------------------------------------------------------------------------------------------------------------------------------


	sed "s/controllertwo=.*/controllertwo="$controllertwo"/g" ~/pullstack/autostack/linecounterfiles/controller.properties > tmp
	mv tmp ~/pullstack/autostack/linecounterfiles/controller.properties


	fi
	exit
