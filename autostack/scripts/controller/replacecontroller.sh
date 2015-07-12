#!/bin/bash

. ~/open/autostack.properties

filename=`basename "$0"`
today=`date +%Y-%m-%d.%H:%M:%S`

exec 2> >(tee "Error_.$filename._.$today.err")
exec > >(tee "Log_.$filename._.$today.log")

echo -----------------############### NOW IN REPLACE CONTROLLER.SH FILE -###############-----------------

replace "NETWORK_PRIVATE_INTERFACE_NAME" $NETWORK_PRIVATE_INTERFACE_NAME -- ~/pullstack/autostack/conf/*
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


echo -----------------############### LEAVING REPLACE CONTROLLER.SH FILE -###############-----------------

exit

