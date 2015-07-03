#!/bin/bash

rm -rf /etc/resolv.conf
cp ~/autostack/common/resolv.conf /etc/


rm -rf  /etc/hosts

cp ~/autostack/common/hosts /etc/

sudo apt-get update && sudo apt-get update --fix-missing && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y
#in=192.168.4.202
#un= network100
#pn=welcome
#icp=192.168.4.204
#ucp=compute100
#pcp=welcome
#ic=192.168.4.201
#uc=controller10
#pc=welcome
apt-get install ntp
rm -rf /etc/ntp.conf
cp ~/autostack/controller/ntp.conf /etc/
service ntp restart

rm -rf  /var/lib/ntp/ntp.conf.dhcp


#sshpass -p welcome ssh -o StrictHostKeyChecking=no cliqr@192.168.4.202 "sudo -u root  ~/autostack/network/networkntp.sh"
#sshpass -p welcome ssh -o StrictHostKeyChecking=no cliqr@192.168.4.204 "sudo -u root  ~/autostack/compute/computentp.sh"

ntpq -c peers
ntpq -c assoc
ntpq -c peers

#sshpass -p welcome ssh -o StrictHostKeyChecking=no cliqr@192.168.4.202 "sudo -u root  ntpq -c assoc"



rm -rf /etc/resolv.conf
cp ~/autostack/common/resolv.conf /etc/

apt-get install ubuntu-cloud-keyring
echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu" \ "trusty-updates/juno main" > /etc/apt/sources.list.d/cloudarchive-juno.list

sudo apt-get update && sudo apt-get update --fix-missing && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y

apt-get install mariadb-server python-mysqldb -y
rm -rf /etc/mysql/my.cnf
cp ~/autostack/controller/mariadb/my.cnf /etc/mysql/
#above copy is in controller in /freshcont/my.cnf

service mysql restart

apt-get install rabbitmq-server -y

rabbitmqctl change_password guest welcome
# welcome is password

echo ------------------------showing status of rabbit mysql------------------
rabbitmqctl status | grep rabbit



cp /etc/rabbitmq/rabbitmq.config /freshcont/

service rabbitmq-server restart





#It will be configured with all nodes
apt-get install python-software-properties -y
add-apt-repository cloud-archive:juno
apt-get update && apt-get dist-upgrade




mysql -u root -p


apt-get install keystone python-keystoneclient -y
echo ----------- Copy Below Admin Token ----------------------
openssl rand -hex 10
echo _____________________________________________________________


echo ------ Update ~autostack/controller/keystone.conf, change ADMIN_TOKEN with admin token copied and run 'identity.sh' -----------------


exit
~      
