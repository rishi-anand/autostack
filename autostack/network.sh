#!/bin/bash



rm -rf  /etc/network/interfaces
cp /network/interfaces /etc/network/interfaces
sudo apt-get update && sudo apt-get update --fix-missing && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y

reboot





exit