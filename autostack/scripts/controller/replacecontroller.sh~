#!/bin/bash

. autostack.properties

filename=`basename "$0"`
today=`date +%Y-%m-%d.%H:%M:%S`

exec 2> >(tee "Error_.$filename._.$today.err")
exec > >(tee "Log_.$filename._.$today.log")

echo -----------------############### NOW IN REPLACE CONTROLLER.SH FILE -###############-----------------







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



replace "NETWORK_PRIVATE_INTERFACE_NAME" $NETWORK_PRIVATE_INTERFACE_NAME -- ~/pullstack/autostack/conf/* || echo Not able to replace
# export NETWORK_PRIVATE_INTERFACE_NAME = $NETWORK_PRIVATE_INTERFACE_NAME

replace "ACCOUNT_USERNAME" $ACCOUNT_USERNAME -- ~/pullstack/autostack/conf/*

replace "CONTROLLER_NODE_HOSTNAME" $CONTROLLER_NODE_HOSTNAME -- ~/pullstack/autostack/conf/*
replace "CONTROLLER_NODE_PUBLIC_IP" $CONTROLLER_NODE_PUBLIC_IP -- ~/pullstack/autostack/conf/*
replace "CONTROLLER_NODE_PRIVATE_IP" $CONTROLLER_NODE_PRIVATE_IP -- ~/pullstack/autostack/conf/*

replace "NETWORK_NODE_HOSTNAME" $NETWORK_NODE_HOSTNAME -- ~/pullstack/autostack/conf/*
replace "NETWORK_NODE_PUBLIC_IP" $NETWORK_NODE_PUBLIC_IP -- ~/pullstack/autostack/conf/*
replace "NETWORK_NODE_PRIVATE_IP" $NETWORK_NODE_PRIVATE_IP -- ~/pullstack/autostack/conf/*

replace "COMPUTE_NODE_HOSTNAME" $COMPUTE_NODE_HOSTNAME -- ~/pullstack/autostack/conf/*
replace "COMPUTE_NODE_PUBLIC_IP" $COMPUTE_NODE_PUBLIC_IP -- ~/pullstack/autostack/conf/*
replace "COMPUTE_NODE_PRIVATE_IP" $COMPUTE_NODE_PRIVATE_IP -- ~/pullstack/autostack/conf/*


replace "NETWORK_PUBLIC_INTERFACE_NAME" $NETWORK_PUBLIC_INTERFACE_NAME -- ~/pullstack/autostack/conf/*
replace "NETWORK_NETMASK_PUBLIC_INTERFACE" $NETWORK_NETMASK_PUBLIC_INTERFACE -- ~/pullstack/autostack/conf/*
replace "NETWORK_NETWORK_PUBLIC_INTERFACE" $NETWORK_NETWORK_PUBLIC_INTERFACE -- ~/pullstack/autostack/conf/*
replace "NETWORK_BROADCAST_PUBLIC_INTERFACE" $NETWORK_BROADCAST_PUBLIC_INTERFACE -- ~/pullstack/autostack/conf/*
replace "NETWORK_GATEWAY_PUBLIC_INTERFACE" $NETWORK_GATEWAY_PUBLIC_INTERFACE -- ~/pullstack/autostack/conf/*

replace "NETWORK_PRIVATE_INTERFACE_NAME" $NETWORK_PRIVATE_INTERFACE_NAME -- ~/pullstack/autostack/conf/*
replace "NETWORK_NETMASK_PRIVATE_INTERFACE" $NETWORK_NETMASK_PRIVATE_INTERFACE -- ~/pullstack/autostack/conf/*
replace "NETWORK_NETWORK_PRIVATE_INTERFACE" $NETWORK_NETWORK_PRIVATE_INTERFACE -- ~/pullstack/autostack/conf/*
replace "NETWORK_BROADCAST_PRIVATE_INTERFACE" $NETWORK_BROADCAST_PRIVATE_INTERFACE -- ~/pullstack/autostack/conf/*
replace "NETWORK_GATEWAY_PRIVATE_INTERFACE" $NETWORK_GATEWAY_PRIVATE_INTERFACE -- ~/pullstack/autostack/conf/*

replace "NETWORK_EXTERNAL_INTERFACE_NAME" $NETWORK_EXTERNAL_INTERFACE_NAME -- ~/pullstack/autostack/conf/*

replace "RABBIT_PASS" $RABBIT_PASS -- ~/pullstack/autostack/conf/*
replace "KEYSTONE_DBPASS" $KEYSTONE_DBPASS -- ~/pullstack/autostack/conf/*
replace "DEMO_PASS" $DEMO_PASS -- ~/pullstack/autostack/conf/*
replace "ADMIN_PASS" $ADMIN_PASS -- ~/pullstack/autostack/conf/*
replace "GLANCE_DBPASS" $GLANCE_DBPASS -- ~/pullstack/autostack/conf/*
replace "GLANCE_PASS" $GLANCE_PASS -- ~/pullstack/autostack/conf/*
replace "NOVA_DBPASS" $NOVA_DBPASS -- ~/pullstack/autostack/conf/*
replace "NOVA_PASS" $NOVA_PASS -- ~/pullstack/autostack/conf/*
replace "DASH_DBPASS" $DASH_DBPASS -- ~/pullstack/autostack/conf/*
replace "CINDER_DBPASS" $CINDER_DBPASS -- ~/pullstack/autostack/conf/*
replace "CINDER_PASS" $CINDER_PASS -- ~/pullstack/autostack/conf/*
replace "NEUTRON_DBPASS" $EUTRON_DBPASS -- ~/pullstack/autostack/conf/*
replace "NEUTRON_PASS" $NEUTRON_PASS -- ~/pullstack/autostack/conf/*
replace "HEAT_DBPASS" $HEAT_DBPASS -- ~/pullstack/autostack/conf/*
replace "HEAT_PASS" $HEAT_PASS -- ~/pullstack/autostack/conf/*
replace "CEILOMETER_DBPASS" $CEILOMETER_DBPASS -- ~/pullstack/autostack/conf/*
replace "CEILOMETER_PASS" $CEILOMETER_PASS -- ~/pullstack/autostack/conf/*
replace "TROVE_DBPASS" $TROVE_DBPASS -- ~/pullstack/autostack/conf/*
replace "TROVE_PASS" $TROVE_PASS -- ~/pullstack/autostack/conf/*

fi


echo -----------------############### LEAVING REPLACE CONTROLLER.SH FILE -###############-----------------

exit

