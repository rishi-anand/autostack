#!/bin/bash

 service openvswitch-switch restart

ovs-vsctl add-br br-ex

ovs-vsctl add-port br-ex p2p1



service neutron-plugin-openvswitch-agent restart
 service neutron-l3-agent restart
 service neutron-dhcp-agent restart
 service neutron-metadata-agent restart

exit
