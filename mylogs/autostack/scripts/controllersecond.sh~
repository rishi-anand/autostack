#!/bin/bash

linenumber=0
check=true
filename=`basename "$0"`
today=`date +%Y-%m-%d.%H:%M:%S`

. ~/open/autostack.properties

exec 2> >(tee "Error_.$filename._.$today.err")
exec > >(tee "Log_.$filename._.$today.log")

echo Default answer is 1 
echo Enter line number you want to start
read linenumber


if [ "$check" = true ] && [ $linenumber -eq 1 ]; then
((linenumber=linenumber+1))


        if [ -s ~/pullstack/autostack/conf/common/resolv.conf ]; then
        sudo rm -rf /etc/resolv.conf || check=false
        fi
 
echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi


if [ "$check" = true ] && [ $linenumber -eq 2 ]; then
((linenumber=linenumber+1))


              if [ -s ~/pullstack/autostack/conf/common/resolv.conf ]; then
              sudo cp ~/pullstack/autostack/conf/common/resolv.conf /etc/ || check=false
              fi
echo -------------------$filename line no : $linenumber------------------------
#line no 2
fi


if [ "$check" = true ] && [ $linenumber -eq 3 ]; then
((linenumber=linenumber+1))
sudo rm -rf  /etc/hosts || check=false 
echo -------------------$filename line no : $linenumber------------------------
#line no 3
fi


if [ "$check" = true ] && [ $linenumber -eq 4 ]; then
((linenumber=linenumber+1))
sudo cp ~/pullstack/autostack/conf/common/hosts /etc/ || check=false 
echo -------------------$filename line no : $linenumber------------------------
#line no 4
fi


if [ "$check" = true ] && [ $linenumber -eq 5 ]; then
((linenumber=linenumber+1))
sudo apt-get update && sudo apt-get update --fix-missing && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y || check=false 
echo -------------------$filename line no : $linenumber------------------------
#line no 5
fi


if [ "$check" = true ] && [ $linenumber -eq 6 ]; then
((linenumber=linenumber+1))
sudo apt-get install ntp || check=false 
echo -------------------$filename line no : $linenumber------------------------
#line no 6
fi

if [ "$check" = true ] && [ $linenumber -eq 7 ]; then
((linenumber=linenumber+1))
sudo rm -rf /etc/ntp.conf || check=false 
echo -------------------$filename line no : $linenumber------------------------
#line no 7
fi


if [ "$check" = true ] && [ $linenumber -eq 8 ]; then
((linenumber=linenumber+1))
sudo cp ~/pullstack/autostack/conf/controller/ntp.conf /etc/ || check=false 
echo -------------------$filename line no : $linenumber------------------------
#line no 8
fi


if [ "$check" = true ] && [ $linenumber -eq 9 ]; then
((linenumber=linenumber+1))
sudo rm -rf /var/lib/ntp/ntp.conf.dhcp || check=false 
echo -------------------$filename line no : $linenumber------------------------
#line no 9
fi


if [ "$check" = true ] && [ $linenumber -eq 10 ]; then
((linenumber=linenumber+1))


sudo service ntp restart || check=false 
echo -------------------$filename line no : $linenumber------------------------
#line no 10
fi

if [ "$check" = true ] && [ $linenumber -eq 11 ]; then
((linenumber=linenumber+1))

sshpass -p $ACCOUNT_PASSWORD ssh -o StrictHostKeyChecking=no $ACCOUNT_USERNAME@$NETWORK_NODE_PUBLIC_IP "sudo -u root  ~/pullstack/autostack/conf/network/networkntp.sh" || check=false 
echo -------------------$filename line no : $linenumber------------------------
#line no 11
fi

if [ "$check" = true ] && [ $linenumber -eq 12 ]; then
((linenumber=linenumber+1))
sshpass -p $ACCOUNT_PASSWORD ssh -o StrictHostKeyChecking=no $ACCOUNT_USERNAME@$COMPUTE_NODE_PUBLIC_IP "sudo -u root  ~/pullstack/autostack/conf/compute/computentp.sh" || check=false 
echo -------------------$filename line no : $linenumber------------------------
#line no 12
fi


if [ "$check" = true ] && [ $linenumber -eq 13 ]; then
((linenumber=linenumber+1))

sudo ntpq -c peers || check=false 
echo -------------------$filename line no : $linenumber------------------------
#line no 13
fi

if [ "$check" = true ] && [ $linenumber -eq 14 ]; then
((linenumber=linenumber+1))
sudo ntpq -c assoc || check=false 
echo -------------------$filename line no : $linenumber------------------------
#line no 14
fi


if [ "$check" = true ] && [ $linenumber -eq 15 ]; then
((linenumber=linenumber+1))
sudo ntpq -c peers || check=false 
echo -------------------$filename line no : $linenumber------------------------
#line no 15
fi

if [ "$check" = true ] && [ $linenumber -eq 16 ]; then
((linenumber=linenumber+1))
echo ntpc -c asoc at Network Node
sshpass -p $ACCOUNT_PASSWORD ssh -o StrictHostKeyChecking=no $ACCOUNT_USERNAME@$NETWORK_NODE_PUBLIC_IP "sudo -u root  ntpq -c assoc" || check=false 
echo -------------------$filename line no : $linenumber------------------------
#line no 16
fi

if [ "$check" = true ] && [ $linenumber -eq 17 ]; then
((linenumber=linenumber+1))


#sudo rm -rf /etc/resolv.conf || check=false 
echo -------------------$filename line no : $linenumber------------------------
#line no 17
fi


if [ "$check" = true ] && [ $linenumber -eq 18 ]; then
((linenumber=linenumber+1))
#sudo cp ~/pullstack/autostack/conf/common/resolv.conf /etc/ || check=false 
echo -------------------$filename line no : $linenumber------------------------
#line no 18
fi

if [ "$check" = true ] && [ $linenumber -eq 19 ]; then
((linenumber=linenumber+1))
sudo apt-get install ubuntu-cloud-keyring || check=false 
echo -------------------$filename line no : $linenumber------------------------
#line no 19
fi

if [ "$check" = true ] && [ $linenumber -eq 20 ]; then
((linenumber=linenumber+1))

sudo echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu" \
  "trusty-updates/juno main" > /etc/apt/sources.list.d/cloudarchive-juno.list || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 20
fi

if [ "$check" = true ] && [ $linenumber -eq 21 ]; then
((linenumber=linenumber+1))
sudo apt-get update && sudo apt-get update --fix-missing && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y || check=false 
echo -------------------$filename line no : $linenumber------------------------
#line no 21
fi



if [ "$check" = true ] && [ $linenumber -eq 22 ]; then
((linenumber=linenumber+1))
sudo apt-get install mariadb-server python-mysqldb -y || check=false 
echo -------------------$filename line no : $linenumber------------------------
#line no 22
fi

if [ "$check" = true ] && [ $linenumber -eq 23 ]; then
((linenumber=linenumber+1))
 if [ -s ~/pullstack/autostack/conf/controller/mariadb/my.cnf ]; then
sudo rm -rf /etc/mysql/my.cnf || check=false 
fi
echo -------------------$filename line no : $linenumber------------------------
#line no 23
fi


if [ "$check" = true ] && [ $linenumber -eq 24 ]; then
((linenumber=linenumber+1))
if [ -s ~/pullstack/autostack/conf/controller/mariadb/my.cnf ]; then
sudo cp ~/pullstack/autostack/conf/controller/mariadb/my.cnf /etc/mysql/ || check=false
fi
echo -------------------$filename line no : $linenumber------------------------
#line no 24
fi


if [ "$check" = true ] && [ $linenumber -eq 25 ]; then
((linenumber=linenumber+1))
#above copy is in controller in /freshcont/my.cnf

sudo service mysql restart || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 25
fi

if [ "$check" = true ] && [ $linenumber -eq 26 ]; then
((linenumber=linenumber+1))

sudo apt-get install rabbitmq-server -y || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 26
fi

if [ "$check" = true ] && [ $linenumber -eq 27 ]; then
((linenumber=linenumber+1))

sudo rabbitmqctl change_password guest $ACCOUNT_PASSWORD || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 27
fi


if [ "$check" = true ] && [ $linenumber -eq 28 ]; then
((linenumber=linenumber+1))
# $ACCOUNT_PASSWORD is password

echo ------------------------showing status of rabbit mysql------------------
sudo rabbitmqctl status | grep rabbit || check=false

echo -------------------$filename line no : $linenumber------------------------
#line no 28
fi

if [ "$check" = true ] && [ $linenumber -eq 29 ]; then
((linenumber=linenumber+1))
if [ -s ~/pullstack/autostack/conf/controller/rabbitmq.config ]; then
sudo cp ~/pullstack/autostack/conf/controller/rabbitmq.config /etc/rabbitmq/ || check=false
fi
echo -------------------$filename line no : $linenumber------------------------
#line no 29
fi


if [ "$check" = true ] && [ $linenumber -eq 30 ]; then
((linenumber=linenumber+1))

sudo service rabbitmq-server restart || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 30
fi



if [ "$check" = true ] && [ $linenumber -eq 31 ]; then
((linenumber=linenumber+1))

echo ==== CREATE DATABASE keystone ====
echo ==== GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' \
  IDENTIFIED BY 'KEYSTONE_DBPASS' ====
echo ==== GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' \
  IDENTIFIED BY 'KEYSTONE_DBPASS' ====
echo ==== exit ====
#mysql -u root -p || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 31
fi


if [ "$check" = true ] && [ $linenumber -eq 32 ]; then
((linenumber=linenumber+1))
sudo apt-get install keystone python-keystoneclient -y || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 32
fi

if [ "$check" = true ] && [ $linenumber -eq 33 ]; then
((linenumber=linenumber+1))
echo ----------- Copy Below Admin Token ----------------------
ADMIN_TOKEN=$(openssl rand -hex 10) || check=false
echo -------------------$filename line no : $linenumber------------------------
#line no 33
fi

replace "ADMIN_TOKEN" $ADMIN_TOKEN -- ~/pullstack/autostack/conf/controller/keystone.conf
#echo ------ Update ~autostack/controller/keystone.conf, change ADMIN_TOKEN with admin token copied and run 'controllerthird.sh'  -----------------


exit
