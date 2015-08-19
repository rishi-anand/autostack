#!/bin/bash



show_starting() {


clear
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
	echo -e '\t''\t''\t''\t''\t''\t'-##------------------------------------------------------##
	echo -e '\t''\t''\t''\t''\t''\t'-# '\t''\t''\t'AutoStack'\t''\t''\t' -#
	echo -e '\t''\t''\t''\t''\t''\t'-# '\t''\t''\t''\t''\t''\t''\t' -#
	echo -e '\t''\t''\t''\t''\t''\t'-# '\t''\t''\t''\t''\t''\t''\t' -#
	echo -e '\t''\t''\t''\t''\t''\t'-# '\t''\t'OpenStack MultiNode Installer'\t''\t' -#
	echo -e '\t''\t''\t''\t''\t''\t'-# '\t''\t''\t''\t''\t''\t''\t' -#
	echo -e '\t''\t''\t''\t''\t''\t'-##------------------------------------------------------##
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo -e '\t''\t''\t' This script will create Environment ready \for OpenStack Installation. This Node will be Network Node.
echo
echo
echo
echo


sleep 6
}

show_starting



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

   echo networkone=1 >> controller.properties
   echo controllertwo=1 >> controller.properties
   echo controllerthree=1 >> controller.properties
   echo controllerfour=1 >> controller.properties
   
   echo computeone=1 >> compute.properties
   echo computetwo=1 >> compute.properties
   echo computethree=1 >> compute.properties
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

   echo networkone=1 >> controller.properties
   echo controllertwo=1 >> controller.properties
   echo controllerthree=1 >> controller.properties
   echo controllerfour=1 >> controller.properties
   
   fi

   if [ ! -f ~/pullstack/autostack/linecounterfiles/compute.properties ]; then

   cd ~/pullstack/autostack/linecounterfiles/
   touch compute.properties
   sudo chmod 765 compute.properties

   echo computeone=1 >> compute.properties
   echo computetwo=1 >> compute.properties
   echo computethree=1 >> compute.properties
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

   #echo networkone=1 >> controller.properties
   #echo controllertwo=1 >> controller.properties
   #echo controllerthree=1 >> controller.properties
   #echo controllerfour=1 >> controller.properties
   pwd
fi


. ~/pullstack/autostack/linecounterfiles/network.properties
. ~/pullstack/autostack/autostack.properties


#-------------- Check if script is already executed [ START ] ---------------------------------
if [ "$networkone" -eq 11 ]; then

echo -----------------------------------------------------
echo \|   This Shell Script has been Executed Successfully. \|
echo -----------------------------------------------------

echo If you Want to execute it again Press [y/n] to Execute it.
read userchoice
     if [ "$userchoice" = "y" ]; then
     echo Enter Line Number you want to continue: [Valid 1 - 10] 
     echo And Execute it again.
     read againlinenumber

    sed "s/computeone=.*/computeone=$againlinenumber/g" ~/pullstack/autostack/linecounterfiles/controller.properties > tmp
    mv tmp ~/pullstack/autostack/linecounterfiles/controller.properties 
fi

exit
else

echo Starting "$filename"
fi


#-------------- Check if script is already executed [ ENDS ] ---------------------------------

check=true
usercreate=true
filename=`basename "$0"`
today=`date +%Y-%m-%d.%H:%M:%S`


exec 2> >(tee "Error_.$filename._.$today.err")
exec > >(tee "Log_.$filename._.$today.log")



# Define your function here
line_counter_increment () {
   sed "s/networkone=.*/networkone=$count/g" ~/open/linecounterfiles/controller.properties > tmp
   mv tmp ~/open/linecounterfiles/controller.properties
   
   
   return "$networkone"
}


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

echo ======= Counter Value is "$networkone" =============

echo ---- If above information is correct then- Press y to continue------
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
source=$HOME/pullstack
destination=/home/autostack/pullstack/

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




if [ "$check" = true ] && [ "$networkone" -eq 1 ]; then
        if [ -s ~/pullstack/autostack/conf/common/resolv.conf ]; then
        #sudo rm -rf /etc/resolv.conf || (check=false && line_counter_increment 1 )
        pwd
        fi
echo -------------------$filename line no : "$networkone"------------------------
#line no 1
((networkone=networkone+1))
fi

if [ "$check" = true ] && [ "$networkone" -eq 2 ]; then
       if [ -s ~/pullstack/autostack/conf/common/resolv.conf ]; then
       #sudo cp ~/pullstack/autostack/conf/common/resolv.conf /etc/ || (check=false && line_counter_increment 2 )
       pwd
       fi
echo -------------------$filename line no : "$networkone"------------------------
#line no 2
((networkone=networkone+1))
fi

if [ "$check" = true ] && [ "$networkone" -eq 3 ]; then
  sudo apt-get update || check=false
          # if [ "$check" = false ]; then
          # line_counter_increment 3
          # fi
#(check=false && line_counter_increment 3 )
echo -------------------$filename line no : "$networkone"------------------------
#line no 3
((networkone=networkone+1))
fi

if [ "$check" = true ] && [ "$networkone" -eq 4 ]; then


echo -------- installing openssh server ----------
sudo apt-get install openssh-server -y || check=false
echo -------- installing ssh-pass -----------
sudo apt-get install sshpass -y || check=false
echo -------------------$filename line no : "$networkone"------------------------
#line no 4
((networkone=networkone+1))
fi

if [ "$check" = true ] && [ "$networkone" -eq 5 ]; then



sudo apt-get install ubuntu-cloud-keyring || check=false

echo -------------------$filename line no : "$networkone"------------------------
#line no 5
((networkone=networkone+1))
fi

if [ "$check" = true ] && [ "$networkone" -eq 6 ]; then


echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu" \
  "trusty-updates/juno main" > /etc/apt/sources.list.d/cloudarchive-juno.list || check=false
echo -------------------$filename line no : "$networkone"------------------------
#line no 6
((networkone=networkone+1))
fi

if [ "$check" = true ] && [ "$networkone" -eq 7 ]; then

sudo apt-get update && sudo apt-get update --fix-missing && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y || check=false

echo -------------------$filename line no : "$networkone"------------------------
#line no 7
((networkone=networkone+1))
fi


if [ "$check" = true ] && [ "$networkone" -eq 8 ]; then

echo -------------- REPLACING ALL PARAMETERS -----------------------------------------------------------------

sudo chmod 755 ~/pullstack/autostack/scripts/network/replace.sh
( exec "~/pullstack/autostack/scripts/network/./replace.sh" ) || check=false
replacemsg=true
echo -------------------$filename line no : "$networkone"------------------------
#line no 8
((networkone=networkone+1))
fi



if [ "$check" = true ] && [ "$networkone" -eq 9 ]; then

chmod 755 ~/pullstack/autostack/scripts/network/replace.sh || echo "Unable to set Permission"
chmod 755 ~/pullstack/autostack/scripts/network/networkfirst.sh || echo "Unable to set Permission"
chmod 755 ~/pullstack/autostack/scripts/network/networknetwork.sh || echo "Unable to set Permission"
chmod 755 ~/pullstack/autostack/scripts/network/networknetworksecond.sh || echo "Unable to set Permission"
chmod 755 ~/pullstack/autostack/scripts/network/networkntp.sh || echo "Unable to set Permission"
echo -------------------$filename line no : "$networkone"------------------------
#line no 9
((networkone=networkone+1))

fi




if [ "$check" = true ] && [ "$networkone" -eq 10 ]; then
       if [ -s ~/pullstack/autostack/conf/network/interfaces ]; then

        echo -###################################### Check Network Configuration -######################################
       cat ~/pullstack/autostack/conf/network/interfaces

       echo -###################################### Check Network Configuration -######################################

         echo ---  Press[y/n] to continue- or to skip -----
       read choicenetwork
                 if [ "$choicenetwork" = "y" ]; then
                 sudo rm -rf  /etc/network/interfaces || check=false
                 sudo cp ~/pullstack/autostack/conf/network/interfaces /etc/network/ || check=false
                 echo -###################################### REBOOTING CONTROLLER -######################################
                 hostname=$(hostname)
                 echo   ---------------------------------------------------------------------------
                 echo \|  [ Static IP is configured. New IP of $NETWORK_NODE_HOSTNAME = $NETWORK_NODE_PUBLIC_IP ] \|
                 echo   ---------------------------------------------------------------------------
                 sudo chmod 755 controllersecond.sh
                 echo   ------------------------------------------------------------------
                 echo \|  [ NOTE : Execute autostack.sh after booting up to proceed further] \|
                 echo   ------------------------------------------------------------------
                 fi

  
        else 
        echo --- Network Interfaces was not found at pullstack repository, Leaving it unchanged-----
        fi



if [ -s ~/pullstack/autostack/conf/network/hostname ]; then
sudo rm -rf /etc/hostname || check=false
sudo cp ~/pullstack/autostack/conf/network/hostname /etc/hostname || check=false
else
echo --------------------------------------------------------------------------------
echo ----------- BASIC : /etc/hostname  [ NOT EDITED ] -------------
echo -----------------------------------------------------------------------------------
fi
    

if [ -s ~/pullstack/autostack/conf/common/hosts ]; then
sudo rm -rf /etc/hosts || check=false
sudo cp ~/pullstack/autostack/conf/common/hosts /etc/hosts || check=false
else
echo --------------------------------------------------------------------------------
echo ----------- BASIC : /etc/hosts  [ NOT EDITED ] -------------
echo -----------------------------------------------------------------------------------
fi


if [ -z "$ACCOUNT_USERNAME" ]
then
echo
echo Enter account name on remote machine through \which remote connection is to be made.
read ACCOUNT_USERNAME
fi
sudo cp ~/pullstack/autostack/scripts/network/* /home/"$ACCOUNT_USERNAME"/

echo -------------------$filename line no : "$networkone"------------------------
#line no 10
((networkone=networkone+1))


sudo chmod 755 controllerfirst.sh
echo ------------------ Now Execute controllerfirst.sh -------------------------------------

((networkone=networkone+1))
sed "s/networkone=.*/networkone="$networkone"/g" ~/pullstack/autostack/linecounterfiles/network.properties > tmp
   mv tmp ~/pullstack/autostack/linecounterfiles/network.properties
                 echo   -----------------------------------
                 echo \|  [ This Script Executed Successfully ] \|
                 echo   -----------------------------------



sudo reboot

exit

fi

((networkone=networkone-1))
sed "s/networkone=.*/networkone="$networkone"/g" ~/pullstack/autostack/linecounterfiles/network.properties > tmp
   mv tmp ~/pullstack/autostack/linecounterfiles/network.properties


if [ "$replacemsg" = true ]; then
echo   ---------------------------------------------------------------------------------------------------------------------------------------------
echo \|  [ NOTE : Verify Your configuration at ~/pullstack/autostack/conf/check_autostack_configuration.txt and then- only move to next Step ] \|
echo   ---------------------------------------------------------------------------------------------------------------------------------------------
echo
fi



fi

exit
