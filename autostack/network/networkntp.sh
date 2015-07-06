#!/bin/bash

echo ************* INSIDE NETWORK NODE **************
echo ----******--Welcome to network node--******----


linenumber=0
check=true
filename=`basename "$0"`
today=`date +%Y-%m-%d.%H:%M:%S`

exec 2> >(tee "Error_.$filename._.$today.err")
exec > >(tee "Log_.$filename._.$today.log")


if [ "$check" = true ] ; then
((linenumber=linenumber+1))

sudo apt-get update || check=false 
echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))


apt-get install ntp
echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

rm -rf /etc/ntp.conf
echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))
echo -----------copy----------------------
cp ~/autostack/autostack/network/ntp.conf /etc/
echo --------------------copy done---------------

echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

if [ "$check" = true ] ; then
((linenumber=linenumber+1))

service ntp restart
echo -------------------$filename line no : $linenumber------------------------
#line no 1
fi

echo *************** RETURNING FROM NETWORK NODE ***************


exit
