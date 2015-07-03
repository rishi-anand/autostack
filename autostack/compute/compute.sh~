#!/bin/bash

echo ----------------------Welcome to network node--------------------
apt-get update

apt-get install ntp

rm -rf /etc/ntp.conf
echo -----------copy----------------------
cp ~/autostack/network/ntp.conf /etc/
echo --------------------copy done---------------
service ntp restart

echo -------------------returning from network node-----------------



exit
