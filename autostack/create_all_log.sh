  #!/bin/bash

   
    # Set some variables here
#filename=`basename "$0"`
    numberoflines=50
    logfile="/var/log/vmware/vmware-usbarb-3360.log"
    today=`date +%Y-%m-%d.%H:%M:%S`
    filenamewithoutdate=Log_all.log
    filenamewithdate=Log_.$today.log
    email="rishi@cliqr.com"
    
    pattern1="ERROR"
    pattern2="error"
    pattern3="Error" 

 if [ ! -e "$filenamewithoutdate" ]
         then
         touch -- "$filenamewithoutdate"
            echo -------
            echo Creating New Log file : $directory/$filenamewithoutdate
            echo ------- 
     else  
            echo -------
            echo Appending Previous Log file : $directory/$filenamewithoutdate
            echo ------- 
 fi

   
    declare -a logfiles=("/var/log/vmware/vmware-usbarb-3360.log" "/var/log/vmware/vmware-usbarb-721.log" "/var/log/glance/api.log" "/var/log/glance/registry.log" "/var/log/keystone/keystone-all.log" "/var/log/keystone/keystone-manage.log" "/var/log/keystone/keystone-all.log" "/var/log/neutron/dhcp-agent.log" "/var/log/neutron/l3-agent.log" "/var/log/neutron/metadata-agent.log" "/var/log/neutron/openvswitch-agent.log" "/var/log/neutron/ovs-cleanup.log" "/var/log/nova/nova-api.log" "/var/log/nova/nova-cert.log" "/var/log/nova/nova-conductor.log" "/var/log/nova/nova-consoleauth.log" "/var/log/nova/nova-manage.log" "/var/log/nova/nova-novncproxy.log" "/var/log/nova/nova-compute.log" "/var/log/nova/nova-scheduler.log" "/var/log/openvswitch/ovs-ctl.log" "/var/log/openvswitch/ovsdb-server.log" "/var/log/openvswitch/ovs-vswitchd.log" "/var/log/rabbitmq/shutdown_err" "/var/log/rabbitmq/startup_err" "/var/log/rabbitmq/startup_log" "/var/log/rabbitmq/shutdown_log")

    

      for i in "${logfiles[@]}"
      
          do
         if [ -e "$i" ]; then
          sudo echo ==== >> $filenamewithoutdate
          sudo echo ==== >> $filenamewithoutdate
          sudo echo ==== >> $filenamewithoutdate
          sudo echo -------------------------------- "$i" ------------------------------------>> $filenamewithoutdate
          sudo echo ==== >> $filenamewithoutdate
         echo "$i"

          
          sudo tail -n $numberoflines "$i" | while read line ; do
          sudo echo "$line" >> $filenamewithoutdate
          


##################################### Below Line of code will search for a pattern and echo it on screen with line number ##########################################
    
  # check each line against our pattern ,if a line matches... , send an email!

     sudo echo "$line" | grep -i "$pattern1"
           if [ $? = 0 ]; then
            sudo echo "Found an error: $line" | mail $email -s ERROR
            sudo echo ERROR#######ERROR######ERROR########ERROR#######ERROR######ERROR#######ERROR#######ERROR###### >> $filenamewithoutdate
            
           fi
     sudo echo "$line" | grep -i "$pattern2"
           if [ $? = 0 ]; then
            sudo echo "Found an error: $line" | mail $email -s ERROR
            sudo echo ERROR#######ERROR######ERROR########ERROR#######ERROR######ERROR#######ERROR#######ERROR###### >> $filenamewithoutdate

           fi
     sudo echo "$line" | grep -i "$pattern3"
           if [ $? = 0 ]; then
            sudo echo "Found an error: $line" | mail $email -s ERROR
            sudo echo ERROR#######ERROR######ERROR########ERROR#######ERROR######ERROR#######ERROR#######ERROR###### >> $filenamewithoutdate

           fi
     
##################################### Above Line of code will search for a pattern and echo it on screen with line number ##########################################


          done
        fi
      done

exit
