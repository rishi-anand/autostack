#!/bin/bash


. ~/pullstack/autostack/autostack.properties

check=true
filename=`basename "$0"`
today=`date +%Y-%m-%d.%H:%M:%S`
computefirst=1

exec 2> >(tee "Error_.$filename._.$today.err")
exec > >(tee "Log_.$filename._.$today.log")


echo COMPUTE_NODE_HOSTNAME = $COMPUTE_NODE_HOSTNAME
echo COMPUTE_NODE_PUBLIC_IP = $COMPUTE_NODE_PUBLIC_IP
echo COMPUTE_NODE_PRIVATE_IP = $COMPUTE_NODE_PRIVATE_IP


echo ---- If above information is correct then- Press y to continue------
echo ---- otherwise add configurations in- ~/pullstack/autostack/autostack.properties -----

echo --- Press[y/n] to continue- or to skip------

read choice
if [ "$choice" = "y" ]; then


if [ "$check" = true ] && [ $computefirst -eq 1 ]; then
       if [ -s ~/pullstack/autostack/conf/controller/interfaces ]; then

        echo -###################################### Check Network Configuration -######################################
       cat ~/pullstack/autostack/conf/controller/interfaces

       echo -###################################### Check Network Configuration -######################################

         echo ---  Press[y/n] to continue- or to skip -----
       read choicenetwork
                 if [ "$choicenetwork" = "y" ]; then
                 sudo rm -rf  /etc/network/interfaces || check=false
                 sudo cp ~/pullstack/autostack/conf/controller/interfaces /etc/network/ || check=false
                 echo -###################################### REBOOTING CONTROLLER -######################################
                 hostname=$(hostname)
                 echo   ---------------------------------------------------------------------------
                 echo \|  [ Static IP is configured. New IP of $hostname = $COMPUTE_NODE_PUBLIC_IP ] \|
                 echo   ---------------------------------------------------------------------------
                 sudo reboot
                 fi
    
    
        else 
        echo --- Network Interfaces was not found at pullstack repository, Leaving it unchanged-----
        fi
echo -------------------$filename line no : $computefirst------------------------
#line no 1
fi

fi

exit
