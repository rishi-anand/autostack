#!/bin/bash


rm -rf /etc/keystone/keystone.conf

cp ~/autostack/controller/keystone.conf /etc/keystone/ 

su -s /bin/sh -c "keystone-manage db_sync" keystone

service keystone restart
rm -f /var/lib/keystone/keystone.db

(crontab -l -u keystone 2>&1 | grep -q token_flush) || \
  echo '@hourly /usr/bin/keystone-manage token_flush >/var/log/keystone/keystone-tokenflush.log 2>&1' \
  >> /var/spool/cron/crontabs/keystone

echo ---------Enter previously copied Admin Token-------------
read ADMIN_TOKEN
export OS_SERVICE_TOKEN=$ADMIN_TOKEN
export OS_SERVICE_ENDPOINT=http://controller10:35357/v2.0
keystone tenant-creazip -r zipfile.zip . -x ".*" -x "*/.*"te --name admin --description "Admin Tenant"

echo ---------Enter Admin Password----------------------------------------
read ADMIN_PASS
echo ---------Enter Admin Email Id ------------------------------------------
read EMAIL_ADDRESS

keystone user-create --name admin --pass $ADMIN_PASS --email $EMAIL_ADDRESS

keystone role-create --name admin

keystone user-role-add --user admin --tenant admin --role admin

keystone tenant-create --name demo --description "Demo Tenant"

keystone user-create --name demo --tenant demo --pass $ADMIN_PASS --email $EMAIL_ADDRESS

keystone tenant-create --name service --description "Service Tenant"


keystone service-create --name keystone --type identity \
  --description "OpenStack Identity"

export OS_SERVICE_TOKEN=$ADMIN_TOKEN
export OS_SERVICE_ENDPOINT=http://controller10:35357/v2.0

keystone endpoint-create \
  --service-id $(keystone service-list | awk '/ identity / {print $2}') \
  --publicurl http://controller10:5000/v2.0 \
  --internalurl http://controller10:5000/v2.0 \ source admin-openrc.sh
  --adminurl http://controller10:35357/v2.0 \
  --region regionOne


echo "Verifying Operation"

unset OS_SERVICE_TOKEN OS_SERVICE_ENDPOINT

keystone --os-tenant-name admin --os-username admin --os-password welcome \
  --os-auth-url http://controller10:35357/v2.0 token-get



keystone --os-tenant-name admin --os-username admin --os-password welcome \
  --os-auth-url http://controller10:35357/v2.0 tenant-list

keystone --os-tenant-name admin --os-username admin --os-password $ADMIN_PASS \
  --os-auth-url http://controller10:35357/v2.0 user-list


keystone --os-tenant-name admin --os-username admin --os-password $ADMIN_PASS \
  --os-auth-url http://controller10:35357/v2.0 role-list


keystone --os-tenant-name demo --os-username demo --os-password welcome \
  --os-auth-url http://controller10:35357/v2.0 token-get

keystone --os-tenant-name demo --os-username demo --os-password welcome \
  --os-auth-url http://controller10:35357/v2.0 user-list




cp ~/autostack/controller/admin-openrc.sh ~/
cp ~/autostack/controller/demo-openrc.sh ~/

source admin-openrc.sh



echo -------Copy These Lines and paste as it is by editing password.-------

echo -------- CREATE DATABASE glance;--------
echo ------ GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'localhost' \ IDENTIFIED BY 'GLANCE_DBPASS';-------
echo -------GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'%' \ IDENTIFIED BY 'GLANCE_DBPASS';----------
echo ---------- exit-----------

mysql -u root -p




cd ~
zip -r zipfile.zip . -x ".*" -x "*/.*"
source admin-openrc.sh

keystone user-create --name glance --pass $ADMIN_PASS

keystone user-role-add --user glance --tenant service --role admin

keystone service-create --name glance --type image \ --description "OpenStack Image Service"

keystone endpoint-create \
  --service-id $(keystone service-list | awk '/ image / {print $2}') \
  --publicurl http://controller10:9292 \
  --internalurl http://controller10:9292 \
  --adminurl http://controller10:9292 \
  --region regionOne


apt-get install glance python-glanceclient -y

rm -rf /etc/glance/glance-api.conf
cp ~/autostack/controller/glance-api.conf /etc/glance/


rm -rf /etc/glance/glance-registry.conf
cp ~/autostack/controller/glance-registry.conf /etc/glance/

su -s /bin/sh -c "glance-manage db_sync" glance

service glance-registry restart

service glance-api restart

rm -f /var/lib/glance/glance.sqlite
cd ~
mkdir /tmp/images

wget -P /tmp/images http://download.cirros-cloud.net/0.3.3/cirros-0.3.3-x86_64-disk.img

cd ~
source admin-openrc.sh

glance image-create --name "cirros-0.3.3-x86_64" --file /tmp/images/cirros-0.3.3-x86_64-disk.img \
  --disk-format qcow2 --container-format bare --is-public True --progress

glance image-list

rm -r /tmp/imageszip -r zipfile.zip . -x ".*" -x "*/.*"

echo -----#####---Installing Compute Services------#####----------

echo -------Copy These Lines and paste as it is by editing password.-------
echo --------CREATE DATABASE nova;-----------
echo ---------GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'localhost' \ IDENTIFIED BY 'NOVA_DBPASS';-------zip -r zipfile.zip . -x ".*" -x "*/.*"

echo --------GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'%' \ IDENTIFIED BY 'NOVA_DBPASS';-----------
echo -------exit--------

mysql -u root -p
cd ~
source admin-openrc.sh

keystone user-create --name nova --pass $ADMIN_PASS

keystone user-role-add --user nova --tenant service --role admin
keystone service-create --name nova --type compute \
  --description "OpenStack Compute"
 keystone tenant-create --name admin --description "Admin Tenant"

zip -r zipfile.zip . -x ".*" -x "*/.*"
keystone endpoint-create \
  --service-id $(keystone service-list | awk '/ compute / {print $2}') \
  --publicurl http://controller10:8774/v2/%\(tenant_id\)s \
  --internalurl http://controller10:8774/v2/%\(tenant_id\)s \
  --adminurl http://controller10:8774/v2/%\(tenant_id\)s \
  --region regionOne



apt-get install nova-api nova-cert nova-conductor nova-consoleauth \
  nova-novncproxy nova-scheduler python-novaclient -y

rm -rf /etc/nova/nova.conf
cp ~/autostack/controller/nova.conf /etc/nova/




service nova-api restart
service nova-cert restart
service nova-consoleauth restart
service nova-scheduler restart
service nova-conductor restart
service nova-novncproxy restart


rm -f /var/lib/nova/nova.sqlite



#This is to be installed on Compute Node
#apt-get install nova-compute sysfsutils -y

exit

