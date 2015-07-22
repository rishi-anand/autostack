#!/bin/bash


. ~/pullstack/autostack/conf/linecounterfiles/controller.properties
. ~/pullstack/autostack/conf/autostack.properties

echo ------------------ EXTERNAL & TENANT NETWORK CREATION ---------------------------------------------

#-------------- Check if PREVIOUS script is executed successfully or not [ STARTS ] ---------------------------------
checklastshellscriptexecution=$(cat /etc/network/interfaces | grep $NETWORK_NETMASK_PUBLIC_INTERFACE)
if [ -z "$checklastshellscriptexecution" ]
then
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

echo Created a new super-user : autostack
echo Password :  autostack
fi
fi
echo Last Shell Script is not Executed Properly. Executing it Again may reboot system.
echo After computer reboots, Run This Shell Script Again.


sudo chmod 755 ~/pullstack/autostack/scripts/controller/replace.sh
( exec "~/pullstack/autostack/scripts/controller/./replace.sh" )
sudo chmod 755 ~/pullstack/autostack/scripts/controller/controllerfirst.sh
( exec "~/pullstack/autostack/scripts/controller/./controllerfirst.sh" )

echo   ---------------------------------------------------------------------------------------------------------------------------------------------
echo \|  [ NOTE : Check file- at ~/pullstack/autostack/conf/controller/interfaces and if- file- exist and have correct configuration then- manually copy it to /etc/network/interfaces , Otherwise Download \'AutoStack\'  again and check same file-] \|
echo   ---------------------------------------------------------------------------------------------------------------------------------------------
fi
#-------------- Check if PREVIOUS script is executed successfully or not [ ENDS ] ---------------------------------


#-------------- Check if PRESENT script is already executed [ START ] ---------------------------------
if [ "$controllersixth" -eq 15 ]; then

echo -----------------------------------------------------
echo \|   This Shell Script has been Executed Successfully. \|
echo -----------------------------------------------------

echo If you Want to execute it again Press [y/n] to Execute it.
read userchoice
     if [ "$userchoice" = "y" ]; then
     echo Enter Line Number you want to continue: [Valid 1 - 15] 
     echo And Execute it again.
     read againlinenumber

    sed "s/controllersixth=.*/controllersixth=$againlinenumber/g" ~/pullstack/autostack/linecounterfiles/controller.properties > tmp
    mv tmp ~/pullstack/autostack/linecounterfiles/controller.properties 
fi

exit
else

echo Starting $filename
fi


#-------------- Check if PRESENT script is already executed [ ENDS ] ---------------------------------


check=true
filename=`basename "$0"`
today=`date +%Y-%m-%d.%H:%M:%S`


exec 2> >(tee "Error_.$filename._.$today.err")
exec > >(tee "Log_.$filename._.$today.log")


echo DATABASE_PASSWORD = $DATABASE_PASSWORD
echo FLOATING_IP_START = $FLOATING_IP_START
echo FLOATING_IP_END = $FLOATING_IP_END
echo EXTERNAL_NETWORK_GATEWAY = $CEXTERNAL_NETWORK_GATEWAY
echo EXTERNAL_NETWORK_CIDR = $EXTERNAL_NETWORK_CIDR
echo TENANT_NETWORK_GATEWAY = $TENANT_NETWORK_GATEWAY
echo TENANT_NETWORK_CIDR = $TENANT_NETWORK_CIDR

#echo ======= Counter Value is $controllerone =============

sudo echo ---- If above information is correct then- Press y to continue------
sudo echo ---- otherwise add configurations in- ~/pullstack/autostack/autostack.properties -----

echo --- Press[y/n] to continue- or to skip------

read choice
if [ "$choice" = "y" ]; then



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
                              
                               #sudo replace "NAMESERVER_IP" $NAMESERVER_IP -- ~/pullstack/autostack/conf/common/*
                               sudo sed -i -e "s/NAMESERVER_IP/$NAMESERVER_IP/g" ~/pullstack/autostack/conf/common/*
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



if [ "$check" = true ] && [ "$controllersixth" -eq 1 ]; then
source admin-openrc.sh || check=false 
echo -------------------$filename line no : "$controllersixth"------------------------
#line no 1
((controllersixth=controllersixth+1))
fi


if [ "$check" = true ] && [ "$controllersixth" -eq 2 ]; then
source admin-openrc.sh || check=false
neutron net-create ext-net --router:external True \
  --provider:physical_network external --provider:network_type flat
echo -------------------$filename line no : "$controllersixth"------------------------
#line no 2
((controllersixth=controllersixth+1))
fi


if [ "$check" = true ] && [ "$controllersixth" -eq 3 ]; then
neutron subnet-create ext-net --name ext-subnet \
  --allocation-pool start=$FLOATING_IP_START,end=$FLOATING_IP_END \
  --disable-dhcp --gateway $EXTERNAL_NETWORK_GATEWAY $EXTERNAL_NETWORK_CIDR || check=false 

echo -------------------$filename line no : "$controllersixth"------------------------
#line no 3
((controllersixth=controllersixth+1))
fi


if [ "$check" = true ] && [ "$controllersixth" -eq 4 ]; then
neutron net-create admin-net

echo -------------------$filename line no : "$controllersixth"------------------------
#line no 4
((controllersixth=controllersixth+1))
fi


if [ "$check" = true ] && [ "$controllersixth" -eq 5 ]; then
neutron subnet-create admin-net --name admin-subnet \
  --gateway $TENANT_NETWORK_GATEWAY $TENANT_NETWORK_CIDR
echo -------------------$filename line no : "$controllersixth"------------------------
#line no 5
((controllersixth=controllersixth+1))
fi


if [ "$check" = true ] && [ "$controllersixth" -eq 6 ]; then

neutron router-create admin-router
echo -------------------$filename line no : "$controllersixth"------------------------
#line no 6
((controllersixth=controllersixth+1))
fi

if [ "$check" = true ] && [ "$controllersixth" -eq 7 ]; then
neutron router-interface-add admin-router admin-subnet
echo -------------------$filename line no : "$controllersixth"------------------------
#line no 7
((controllersixth=controllersixth+1))
fi


if [ "$check" = true ] && [ "$controllersixth" -eq 8 ]; then
neutron router-gateway-set admin-router ext-net
echo --------------------------------------------
echo It will show : Set gateway -- router admin-router
echo --------------------------------------------
echo -------------------$filename line no : "$controllersixth"------------------------
#line no 8
((controllersixth=controllersixth+1))
fi


if [ "$check" = true ] && [ "$controllersixth" -eq 10 ]; then
source demo-openrc.sh || check=false
neutron net-create demo-net || check=false
echo -------------------$filename line no : "$controllersixth"------------------------
#line no 10
((controllersixth=controllersixth+1))
fi

if [ "$check" = true ] && [ "$controllersixth" -eq 11 ]; then
neutron subnet-create demo-net --name demo-subnet \
  --gateway $TENANT_NETWORK_GATEWAY $TENANT_NETWORK_CIDR || check=false
echo -------------------$filename line no : "$controllersixth"------------------------
#line no 11
((controllersixth=controllersixth+1))
fi

if [ "$check" = true ] && [ "$controllersixth" -eq 12 ]; then
neutron router-create demo-router || check=false 
echo -------------------$filename line no : "$controllersixth"------------------------
#line no 12
((controllersixth=controllersixth+1))
fi

if [ "$check" = true ] && [ "$controllersixth" -eq 13 ]; then
neutron router-interface-add demo-router demo-subnet || check=false
echo -------------------$filename line no : "$controllersixth"------------------------
#line no 13
((controllersixth=controllersixth+1))
fi


if [ "$check" = true ] && [ "$controllersixth" -eq 14 ]; then
eutron router-gateway-set demo-router ext-net || check=false
echo -------------------$filename line no : "$controllersixth"------------------------
#line no 14
((controllersixth=controllersixth+1))


sed "s/controllersixth=.*/controllersixth="$controllersixth"/g" ~/pullstack/autostack/conf/linecounterfiles/controller.properties > tmp
   mv tmp ~/pullstack/autostack/conf/linecounterfiles/controller.properties
echo   -----------------------------------------------
echo \|  [ NOTE : This shell script executed Successfully . ] \|
echo   -----------------------------------------------

exit
#line no 14
((controllersixth=controllersixth+1))
fi
######################################################################################################


((controllersixth=controllersixth-1))

echo   ---------------------------------------------------------------------------------------------------------------------------------------------
echo \|  [ NOTE : Shell Script Execution Terminated at Line Number : "$controllersixth" , Verify this line and execute same shell script again and it will start there itself . ] \|
echo   ---------------------------------------------------------------------------------------------------------------------------------------------


sed "s/controllersixth=.*/controllersixth="$controllersixth"/g" ~/pullstack/autostack/conf/linecounterfiles/controller.properties > tmp
   mv tmp ~/pullstack/autostack/conf/linecounterfiles/controller.properties


fi
exit
