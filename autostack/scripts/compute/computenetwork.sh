#!/bin/bash

check=true
filename=`basename "$0"`
today=`date +%Y-%m-%d.%H:%M:%S`
replacemsg=false

exec 2> >(tee "Error_.$filename._.$today.err")
exec > >(tee "Log_.$filename._.$today.log")



if [ ! -d ~/pullstack/autostack/linecounterfiles/ ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
   mkdir ~/pullstack/autostack/linecounterfiles/
   sudo chmod 775 /opt/lampp/htdocs
   cd ~/pullstack/autostack/linecounterfiles/
  
   touch controller.properties
   sudo chmod 765 controller.properties
   touch compute.properties
   sudo chmod 765 compute.properties
   touch network.properties
   sudo chmod 765 network.properties

   echo controllerone=1 >> controller.properties
   echo controllertwo=1 >> controller.properties
   echo controllerthree=1 >> controller.properties
   echo controllerfour=1 >> controller.properties
   
   echo computefour=1 >> compute.properties
   echo computefour=1 >> compute.properties
   echo computefour=1 >> compute.properties
   echo computefour=1 >> compute.properties
   
   echo networkone=1 >> network.properties
   echo networktwo=1 >> network.properties
   echo networkthree=1 >> network.properties
   echo networkfour=1 >> network.properties
  
else
 
   if [ ! -f ~/pullstack/autostack/linecounterfiles/controller.properties ]; then
       
   cd ~/pullstack/autostack/linecounterfiles/
   touch controller.properties
   sudo chmod 765 controller.properties

   echo controllerone=1 >> controller.properties
   echo controllertwo=1 >> controller.properties
   echo controllerthree=1 >> controller.properties
   echo controllerfour=1 >> controller.properties
   
   fi

   if [ ! -f ~/pullstack/autostack/linecounterfiles/compute.properties ]; then

   cd ~/pullstack/autostack/linecounterfiles/
   touch compute.properties
   sudo chmod 765 compute.properties

   echo computefour=1 >> compute.properties
   echo computefour=1 >> compute.properties
   echo computefour=1 >> compute.properties
   echo computefour=1 >> compute.properties
   
   fi

   if [ ! -f ~/pullstack/autostack/linecounterfiles/network.properties ]; then

   cd ~/pullstack/autostack/linecounterfiles/
   touch network.properties
   sudo chmod 765 network.properties

   echo networkone=1 >> network.properties
   echo networktwo=1 >> network.properties
   echo networkthree=1 >> network.properties
   echo networkfour=1 >> network.properties
   
   fi
   

fi


if [ ! -f ~/pullstack/autostack/autostack.properties ]; then
       
   cd ~/pullstack/autostack/
   touch controller.properties
   sudo chmod 765 controller.properties

   #echo computefour=1 >> controller.properties
   #echo controllertwo=1 >> controller.properties
   #echo controllerthree=1 >> controller.properties
   #echo controllerfour=1 >> controller.properties
   pwd
fi



hostname=$(hostname)
echo ----******--Welcome to $hostname--******----

. ~/pullstack/autostack/linecounterfiles/compute.properties
. ~/pullstack/autostack/autostack.properties

if [ "$computefour" -eq 7 ]; then

echo -----------------------------------------------------
echo \|   This Shell Script has been Executed Successfully. \|
echo -----------------------------------------------------

echo If you Want to execute it again Press [y/n] to Execute it.
read userchoice
     if [ "$userchoice" = "y" ]; then
     echo Enter Line Number you want to continue: [Valid 1 - 6] 
     echo And Execute it again.
     read againlinenumber

    sed "s/computefour=.*/computefour=$againlinenumber/g" ~/pullstack/autostack/linecounterfiles/compute.properties > tmp
    mv tmp ~/pullstack/autostack/linecounterfiles/compute.properties 
fi

exit
else

echo Starting $filename
fi


# Define your function here
line_counter_increment () {
   sed "s/computefour=.*/computefour=$count/g" ~/pullstack/autostack/linecounterfiles/compute.properties > tmp
   mv tmp ~/pullstack/autostack/linecounterfiles/compute.properties
   return "$computefour"
}




echo COMPUTE_NODE_HOSTNAME = $COMPUTE_NODE_HOSTNAME
echo COMPUTE_NODE_PUBLIC_IP = $COMPUTE_NODE_PUBLIC_IP
echo COMPUTE_NODE_PRIVATE_IP = $COMPUTE_NODE_PRIVATE_IP


echo ======= Counter Value is "$computefour" =============

echo ---- If above information is correct then- Press y to continue- or n to exit------
echo ---- otherwise add configurations in- ~/pullstack/autostack/autostack.properties -----

echo --- Press[y/n] to continue- or to skip------

read choice
if [ "$choice" = "y" ] && [ "$check" = true ]; then

#---------------------- Create User [ START ] ---------------------------------------------
user=$(cut -d: -f1 /etc/passwd | grep autostack)

if [ -z "$user" ]
then
sudo useradd -m -p autostack autostack
echo -e 'autostack\nautostack\n' | sudo passwd autostack || usercreate=false
if [ -s ~/pullstack/autostack/conf/common/autostack ]; then
        sudo cp ~/pullstack/autostack/conf/common/autostack /etc/sudoers.d/     
        fi
if [ "$usercreate" = true ]; then
echo ----------------------------------------
echo \|   Created a new super-user : autostack \|
echo \|   Password of autostack  : autostack . \|
echo ----------------------------------------
source=~/pullstack
destination=/home/autostack/

if [ ! -d "$destination" ]; then
    mkdir -p "$destination"
fi
sudo cp -R "$source" "$destination"
fi
fi
#---------------------- Create User [ ENDS ] ---------------------------------------------


#-------------------- Check if Internet is working if not working then updating Nameserver [STARTS]-----------------------------------
internet_working=true
is_resolv=true
ping -c 3 www.google.com || internet_working=false
if [ "$internet_working" = false ] ; then
    
    name_server=$(cat /etc/resolv.conf | grep $NAMESERVER_IP )
        if [ -z "$name_server" ]
        then
             sudo echo nameserver $NAMESERVER_IP >> /etc/resolv.conf || is_resolv=false
             if [ "$is_resolv" = false ] ; then
                      if [ -s ~/pullstack/autostack/conf/common/resolv.conf ]; then
                              
                               sudo replace "NAMESERVER_IP" $NAMESERVER_IP -- ~/pullstack/autostack/conf/common/*
                               updatednameserverip=$(cat ~/pullstack/autostack/conf/common/resolv.conf | grep $NAMESERVER_IP)
                               if [ ! -z "$updatednameserverip" ]; then
                               sudo rm -rf /etc/resolv.conf
                               sudo cp ~/pullstack/autostack/conf/common/resolv.conf /etc/
                                                      else
                                                      echo ---------------------------------------------------------
                                                      echo \|   Manually Add Nameserver IP in- /etc/resolv.conf file- \|
                                                      echo ---------------------------------------------------------

                               fi
                       else
echo ---------------------------------------------------------
echo \|   Manually Add Nameserver IP in- /etc/resolv.conf file- \|
echo ---------------------------------------------------------


                      fi

             fi

        fi
else
echo --------------------------------
echo \|   Internet is working properly \|
echo --------------------------------
fi
#-------------------- Check if Internet is working if not working then updating Nameserver [ENDS] -------------------------------------------



if [ "$check" = true ] && [ "$computefour" -eq 1 ]; then
sudo apt-get update && sudo apt-get dist-upgrade -y || check=false


echo -------------------$filename line no : "$computefour"------------------------
#line no 1
((computefour=computefour+1))
fi


if [ "$check" = true ] && [ "$computefour" -eq 2 ]; then

sudo apt-get install ubuntu-cloud-keyring || check=false
echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu" \
  "trusty-updates/juno main" > /etc/apt/sources.list.d/cloudarchive-juno.list || check=false
sudo apt-get update && sudo apt-get update --fix-missing && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y || check=false
echo -------------------$filename line no : "$computefour"------------------------
#line no 2
((computefour=computefour+1))
fi

if [ "$check" = true ] && [ "$computefour" -eq 3 ]; then

if [ -s ~/pullstack/autostack/conf/compute/sysctl.conf ]; then
sudo rm -rf /etc/sysctl.conf || check=false
sudo cp ~/pullstack/autostack/conf/compute/sysctl.conf /etc/ || check=false
else
echo --------------------------------------------------------------------------------
echo ----------- NEUTRON [compute] : /etc/sysctl.conf  [ NOT EDITED ] -------------
echo -----------------------------------------------------------------------------------
fi


echo -------------------$filename line no : "$computefour"------------------------
#line no 3
((computefour=computefour+1))
fi

if [ "$check" = true ] && [ "$computefour" -eq 4 ]; then
sudo sysctl -p
echo -------------------$filename line no : "$computefour"------------------------
#line no 4
((computefour=computefour+1))
fi

if [ "$check" = true ] && [ "$computefour" -eq 5 ]; then
sudo apt-get install neutron-plugin-ml2 neutron-plugin-openvswitch-agent -y || check=false

echo -------------------$filename line no : "$computefour"------------------------
#line no 5
((computefour=computefour+1))
fi

if [ "$check" = true ] && [ "$computefour" -eq 6 ]; then
if [ -s ~/pullstack/autostack/conf/compute/neutron.conf ]; then
sudo rm -rf /etc/neutron/neutron.conf || check=false
sudo cp ~/pullstack/autostack/conf/compute/neutron.conf /etc/neutron/ || check=false
else
echo --------------------------------------------------------------------------------
echo ----------- NEUTRON [compute] : /etc/neutron/neutron.conf  [ NOT EDITED ] -------------
echo -----------------------------------------------------------------------------------
fi


echo -------------------$filename line no : "$computefour"------------------------
#line no 6
((computefour=computefour+1))
fi

if [ "$check" = true ] && [ "$computefour" -eq 7 ]; then

if [ -s ~/pullstack/autostack/conf/compute/ml2_conf.ini ]; then
sudo rm -rf /etc/neutron/plugins/ml2/ml2_conf.ini || check=false
sudo cp ~/pullstack/autostack/conf/compute/ml2_conf.ini /etc/neutron/plugins/ml2/ || check=false
else
echo --------------------------------------------------------------------------------
echo ----------- NEUTRON [compute] : /etc/neutron/plugins/ml2/ml2_conf.ini  [ NOT EDITED ] -------------
echo -----------------------------------------------------------------------------------
fi


echo -------------------$filename line no : "$computefour"------------------------
#line no 7
((computefour=computefour+1))
fi


if [ "$check" = true ] && [ "$computefour" -eq 8 ]; then

sudo service openvswitch-switch restart || check=false
echo -------------------$filename line no : "$computefour"------------------------
#line no 8
((computefour=computefour+1))
fi



if [ "$check" = true ] && [ "$computefour" -eq 9 ]; then

if [ -s ~/pullstack/autostack/conf/compute/computenetwork/nova.conf ]; then
sudo rm -rf /etc/nova/nova.conf || check=false
sudo cp ~/pullstack/autostack/conf/compute/computnetwork/nova.conf /etc/nova/ || check=false
else
echo --------------------------------------------------------------------------------
echo ----------- NEUTRON [compute] : /etc/nova/nova.conf  [ NOT EDITED ] -------------
echo -----------------------------------------------------------------------------------
fi
echo -------------------$filename line no : "$computefour"------------------------
#line no 9
((computefour=computefour+1))
fi



if [ "$check" = true ] && [ "$computefour" -eq 10 ]; then
sudo service nova-compute restart || check=false
echo -------------------$filename line no : "$computefour"------------------------
#line no 10
((computefour=computefour+1))
fi


if [ "$check" = true ] && [ "$computefour" -eq 11 ]; then
sudo service neutron-plugin-openvswitch-agent restart || check=false
echo -------------------$filename line no : "$computefour"------------------------
#line no 11
((computefour=computefour+1))

   sed "s/computefour=.*/computefour=$computefour/g" ~/pullstack/autostack/linecounterfiles/compute.properties > tmp
   mv tmp ~/pullstack/autostack/linecounterfiles/compute.properties
echo   ------------------------------------------
echo \|  [ NOTE : Network is set up at compute Node ] \|
echo   ------------------------------------------
echo *************** EXITING FROM COMPUTE NODE ***************
exit
fi



   ((computefour=computefour-1))
   sed "s/computefour=.*/computefour=$computefour/g" ~/pullstack/autostack/linecounterfiles/compute.properties > tmp
   mv tmp ~/pullstack/autostack/linecounterfiles/compute.properties


if [ "$replacemsg" = true ]; then
echo   ---------------------------------------------------------------------------------------------------------------------------------------------
echo \|  [ NOTE : Verify Your configuration at ~/pullstack/autostack/conf/check_autostack_configuration.txt and then- only move to next Step ] \|
echo   ---------------------------------------------------------------------------------------------------------------------------------------------
fi



fi
echo *************** EXITING FROM COMPUTE NODE ***************
exit
