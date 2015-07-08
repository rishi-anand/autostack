#!/bin/bash

. ~/open/autostack.properties

filename=`basename "$0"`
today=`date +%Y-%m-%d.%H:%M:%S`

exec 2> >(tee "Error_.$filename._.$today.err")
exec > >(tee "Log_.$filename._.$today.log")

echo -----------------############### NOW IN REPLACE CONTROLLER.SH FILE -###############-----------------

replace "NETWORK_PRIVATE_INTERFACE_NAME" $NETWORK_PRIVATE_INTERFACE_NAME -- ~/open/acbdefghi/conf/*
# export NETWORK_PRIVATE_INTERFACE_NAME = $NETWORK_PRIVATE_INTERFACE_NAME

replace "ACCOUNT_USERNAME" $ACCOUNT_USERNAME -- ~/open/controller/conf/*

replace "CONTROLLER_NODE_HOSTNAME" $CONTROLLER_NODE_HOSTNAME -- ~/open/acbdefghi/conf/*
replace "CONTROLLER_NODE_PUBLIC_IP" $CONTROLLER_NODE_PUBLIC_IP -- ~/open/acbdefghi/conf/*
replace "CONTROLLER_NODE_PRIVATE_IP" $CONTROLLER_NODE_PRIVATE_IP -- ~/open/acbdefghi/conf/*

replace "NETWORK_NODE_HOSTNAME" $NETWORK_NODE_HOSTNAME -- ~/open/acbdefghi/conf/*
replace "NETWORK_NODE_PUBLIC_IP" $NETWORK_NODE_PUBLIC_IP -- ~/open/acbdefghi/conf/*
replace "NETWORK_NODE_PRIVATE_IP" $NETWORK_NODE_PRIVATE_IP -- ~/open/acbdefghi/conf/*

replace "COMPUTE_NODE_HOSTNAME" $COMPUTE_NODE_HOSTNAME -- ~/open/acbdefghi/conf/*
replace "COMPUTE_NODE_PUBLIC_IP" $COMPUTE_NODE_PUBLIC_IP -- ~/open/acbdefghi/conf/*
replace "COMPUTE_NODE_PRIVATE_IP" $COMPUTE_NODE_PRIVATE_IP -- ~/open/acbdefghi/conf/*


replace "NETWORK_PUBLIC_INTERFACE_NAME" $NETWORK_PUBLIC_INTERFACE_NAME -- ~/open/acbdefghi/conf/*
replace "NETWORK_NETMASK_PUBLIC_INTERFACE" $NETWORK_NETMASK_PUBLIC_INTERFACE -- ~/open/acbdefghi/conf/*
replace "NETWORK_NETWORK_PUBLIC_INTERFACE" $NETWORK_NETWORK_PUBLIC_INTERFACE -- ~/open/acbdefghi/conf/*
replace "NETWORK_BROADCAST_PUBLIC_INTERFACE" $NETWORK_BROADCAST_PUBLIC_INTERFACE -- ~/open/acbdefghi/conf/*
replace "NETWORK_GATEWAY_PUBLIC_INTERFACE" $NETWORK_GATEWAY_PUBLIC_INTERFACE -- ~/open/acbdefghi/conf/*

replace "NETWORK_PRIVATE_INTERFACE_NAME" $NETWORK_PRIVATE_INTERFACE_NAME -- ~/open/acbdefghi/conf/*
replace "NETWORK_NETMASK_PRIVATE_INTERFACE" $NETWORK_NETMASK_PRIVATE_INTERFACE -- ~/open/acbdefghi/conf/*
replace "NETWORK_NETWORK_PRIVATE_INTERFACE" $NETWORK_NETWORK_PRIVATE_INTERFACE -- ~/open/acbdefghi/conf/*
replace "NETWORK_BROADCAST_PRIVATE_INTERFACE" $NETWORK_BROADCAST_PRIVATE_INTERFACE -- ~/open/acbdefghi/conf/*
replace "NETWORK_GATEWAY_PRIVATE_INTERFACE" $NETWORK_GATEWAY_PRIVATE_INTERFACE -- ~/open/acbdefghi/conf/*

replace "NETWORK_EXTERNAL_INTERFACE_NAME" $NETWORK_EXTERNAL_INTERFACE_NAME -- ~/open/acbdefghi/conf/*

replace "RABBIT_PASS" $RABBIT_PASS -- ~/open/acbdefghi/conf/*
replace "KEYSTONE_DBPASS" $KEYSTONE_DBPASS -- ~/open/acbdefghi/conf/*
replace "DEMO_PASS" $DEMO_PASS -- ~/open/acbdefghi/conf/*
replace "ADMIN_PASS" $ADMIN_PASS -- ~/open/acbdefghi/conf/*
replace "GLANCE_DBPASS" $GLANCE_DBPASS -- ~/open/acbdefghi/conf/*
replace "GLANCE_PASS" $GLANCE_PASS -- ~/open/acbdefghi/conf/*
replace "NOVA_DBPASS" $NOVA_DBPASS -- ~/open/acbdefghi/conf/*
replace "NOVA_PASS" $NOVA_PASS -- ~/open/acbdefghi/conf/*
replace "DASH_DBPASS" $DASH_DBPASS -- ~/open/acbdefghi/conf/*
replace "CINDER_DBPASS" $CINDER_DBPASS -- ~/open/acbdefghi/conf/*
replace "CINDER_PASS" $CINDER_PASS -- ~/open/acbdefghi/conf/*
replace "NEUTRON_DBPASS" $EUTRON_DBPASS -- ~/open/acbdefghi/conf/*
replace "NEUTRON_PASS" $NEUTRON_PASS -- ~/open/acbdefghi/conf/*
replace "HEAT_DBPASS" $HEAT_DBPASS -- ~/open/acbdefghi/conf/*
replace "HEAT_PASS" $HEAT_PASS -- ~/open/acbdefghi/conf/*
replace "CEILOMETER_DBPASS" $CEILOMETER_DBPASS -- ~/open/acbdefghi/conf/*
replace "CEILOMETER_PASS" $CEILOMETER_PASS -- ~/open/acbdefghi/conf/*
replace "TROVE_DBPASS" $TROVE_DBPASS -- ~/open/acbdefghi/conf/*
replace "TROVE_PASS" $TROVE_PASS -- ~/open/acbdefghi/conf/*


echo -----------------############### LEAVING REPLACE CONTROLLER.SH FILE -###############-----------------

exit

