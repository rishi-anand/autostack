#!/bin/bash

rm -rf /etc/sysctl.conf
cp ~/autostack/compute/sysctl.conf /etc/
sysctl -p
apt-get install neutron-plugin-ml2 neutron-plugin-openvswitch-agent -y


rm -rf /etc/neutron/neutron.conf
cp ~/autostack/compute/neutron.conf /etc/neutron/

rm -rf /etc/neutron/plugins/ml2/ml2_conf.ini
cp ~/autostack/compute/ml2_conf.ini /etc/neutron/plugins/ml2/

service openvswitch-switch restart

rm -rf /etc/nova/nova.conf
cp ~/autostack/compute/computnetwork/nova.conf /etc/nova/

service nova-compute restart

service neutron-plugin-openvswitch-agent restart



exit



