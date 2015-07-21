#!/bin/bash
today=`date +%Y-%m-%d.%H:%M`

re='^[0-9]+$'
# ----------------------------------- Update your parameters below below this line ---------------------------------------------

# You can create your file name in two ways. This is file name in which all log will be generated.
filenamewithoutdate=log_all.log
filenamewithdate=log_.$today.log

# Change file naming type according to your requirement

# filetobewritten=$filenamewithoutdate
filetobewritten=$filenamewithoutdate

# Change it and update your email id
email="rishianand@cliqr.com"

# You can also check pattern in Log files and can also do specific operation on specific Pattern. You can also make a new pattern by defining new variable and binding it to new operation.
pattern1="ERROR"
pattern2="Error"
pattern3="error" 

# ----------------------------------------- Dont' update anything below this line -----------------------------------------------------

d_check=false
p_check=false
t_check=false
n_check=false
f_check=false
fs_check=false
h_check=false
a_check=false
z_check=false

p_count=0
   d_counter=0
   p_counter=0
   t_counter=0
   n_counter=0
   f_counter=0
   fs_counter=0
   a_counter=0
   z_counter=0
   h_counter=0
   
   d_int=0
   p_int=0
   t_int=0
   n_int=0
   f_int=0
   fs_int=0
   a_int=0
   z_int=0
   h_int=0

append_log=false
log_file_name_with_date=false
EXPECTED_ARGS=2
E_BADARGS=65
counter_info=true
log_property_file=log.properties
man_file=/usr/man/man1/logdebugg.1.gz

show_info() {
	echo
		echo -##---------------------------------------------------------------------------------------------------------------------------------##
		echo -# . . . . . . . . . . . . . . . . . . . . . . . .--==* LOG FILE DEBUGGER *==--. . . . . . . . . . . . . . . . . . . . . . . . . . .-#
		echo - . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .-
		echo - . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .-
		echo - . . . . [ Modes of Operation :3  ---- . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .-
		echo - . . . . . . .1= Default: It takes minimum 2 parameters. 2P=[EG: all_log.sh t/n counter] . 3P=[EG: all_log.sh d t/n counter] . . . .-
		echo - . . . . . . .2= Path : It takes minimum 4 parameters. . 4P=[EG: all_log.sh p t/n counter path_of_log_file ] . . . . . . . . . . . .-
		echo - . . . . . . .3= Folder : It takes minimum 4 parameters. . 4P=[EG: all_log.sh p t/n counter path_of_folder ] . . . . . . . . . . . .-
		echo - . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .-
		echo - . . P= parameters . . . t= timestamp [All Logs will be shown that are touched in past t minutes] . . . n=Number of Lines Method . .- 
		echo -. . . . . . . . . . . . . t counter= No. of minutes . . . . . . . . . . n counter= No. of Lines . . . . . . . . . . . . . . . . . . -
		echo -. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . -
		echo -. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . -
		echo -#. . . . . . . . . . . . . . . . . . . . [ RISHI ANAND ] [ +91 82678-46255 ] [ rishi@cliqr.com ] . . . . . . . . . . . . . . . . . -#
		echo -##---------------------------------------------------------------------------------------------------------------------------------##
		echo
		echo ----------------------------------------------- For more info execute ./all.log.sh r s -----------------------------------------------

}

show_commands () {

echo --------------------------
echo \|   Execute : man logdebugg \|
echo --------------------------
}

qsort() {
   local pivot i smaller=() larger=()
   qsort_ret=()
   (($#==0)) && return 0
   pivot=$1
   shift
   for i; do
      if [[ $i < $pivot ]]; then
         smaller+=( "$i" )
      else
         larger+=( "$i" )
      fi
   done
   qsort "${smaller[@]}"
   smaller=( "${qsort_ret[@]}" )
   qsort "${larger[@]}"
   larger=( "${qsort_ret[@]}" )
   qsort_ret=( "${smaller[@]}" "$pivot" "${larger[@]}" )
}

create_man_page () {

mancheck=/usr/man/
if [ ! -d "$mancheck" ];then
sudo mkdir /usr/man/
fi

mancheckman1=/usr/man/man1
if [ ! -d "$mancheckman1" ];then
sudo mkdir /usr/man/man1/
fi


echo .\" Process this file with >> test.1.g
echo .\" groff -man -Tascii logdebugg.1 >> test.1.g
echo .\" >> test.1.g
echo .TH logdebugg 1 "JULY 2015" Linux "User Manuals" >> test.1.g
echo .SH NAME >> test.1.g
echo logdebugg \-  debuggs and analyzes logs >> test.1.g
echo .SH SYNOPSIS >> test.1.g
echo .B logdebugg [-OPTIONS]... [-c >> test.1.g
echo .I log.properties >> test.1.g
echo .B ] >> test.1.g
echo .I file >> test.1.g
echo .B ... >> test.1.g
echo .SH DESCRIPTION >> test.1.g
echo .B logdebugg >> test.1.g
echo analyzes log based on timestamp or number of tail-lines from >> test.1.g
echo each log file. This Shell Script collects all logs based on user Input Parameters. >> test.1.g
echo Logs can be collected in two Modes:  >> test.1.g
echo .BR TimeStamp >> test.1.g
echo or >> test.1.g
echo .BR No. of Lines >> test.1.g
echo In  >> test.1.g
echo .BR TimeStamp >> test.1.g
echo all logs will be collected which are  >> test.1.g
echo .BR touched  >> test.1.g
echo .BR in  >> test.1.g
echo .BR ‘t’  >> test.1.g
echo .BR minute  >> test.1.g
echo duration. In  >> test.1.g
echo .BR No.  >> test.1.g
echo .BR of   >> test.1.g
echo .BR Lines,  >> test.1.g
echo .BR ‘n’  >> test.1.g
echo .BR number  >> test.1.g
echo .BR of  >> test.1.g
echo .BR logs  >> test.1.g
echo from end will be collected. Input path can be given in two ways: >> test.1.g 
echo by passing argument or by passing address in properties file.  >> test.1.g
echo User input is being  >> test.1.g
echo .BR validated  >> test.1.g
echo and for incorrect user input, User is shown list of Parameters.  >> test.1.g
echo Properties file gets created automatically if do not exist,  >> test.1.g
echo and shows help menu whenever shell script is executed with  >> test.1.g
echo .BR ‘--help command’   >> test.1.g
echo and then user can pass address of  >> test.1.g
echo .BR multiple  >> test.1.g
echo .BR log   >> test.1.g
echo files. >> test.1.g
echo Also it  >> test.1.g
echo .BR Analyses  >> test.1.g
echo .BR log  >> test.1.g
echo .BR files  >> test.1.g
echo with some  >> test.1.g
echo .BR Pattern  >> test.1.g
echo and highlights area of log file where pattern is found and a  >> test.1.g
echo .BR specific  >> test.1.g
echo .BR operation  >> test.1.g
echo .BR can  >> test.1.g
echo .BR be  >> test.1.g
echo .BR performed  >> test.1.g
echo for each  >> test.1.g
echo .BR Pattern  >> test.1.g
echo like  >> test.1.g
echo .BR installing  >> test.1.g
echo .BR a  >> test.1.g
echo .BR service  >> test.1.g
echo or  >> test.1.g
echo .BR moving  >> test.1.g
echo .BR some  >> test.1.g
echo .BR file  >> test.1.g
echo from one directory into another directory. >> test.1.g
echo .SH OPTIONS >> test.1.g
echo .IP -d >> test.1.g
echo Default option. It takes log file path from >> test.1.g 
echo .I 'log.properties'  >> test.1.g
echo file. >> test.1.g
echo .IP "-p" >> test.1.g
echo Takes User Input in argument form. User can pass >> test.1.g 
echo .BR path  >> test.1.g
echo .BR of  >> test.1.g
echo .BR log  >> test.1.g
echo .BR files  >> test.1.g
echo after '-p' command. User can pass any number of log files. >> test.1.g
echo Output file is generated in >> test.1.g
echo .IR 'pwd'. >> test.1.g
echo .IP -t >> test.1.g
echo It filters log file and generates logs that are touched in last >> test.1.g 
echo .I 't' minute. >> test.1.g
echo It expects an integer parameter. However if integer is not passed,  >> test.1.g
echo It takes '5 min' timestamp by default. >> test.1.g
echo .IP -n >> test.1.g
echo It filters log file based on  >> test.1.g
echo .I 'no. of lines' >> test.1.g
echo at tail from each log file. It expects an integer parameter. However if integer is not passed, >> test.1.g 
echo It takes '50 lines' by default.  >> test.1.g
echo .IP -f >> test.1.g
echo It filters all log files in folder that is given by user following >> test.1.g
echo .I '-f' parameter  >> test.1.g
echo and generates logs based on what user chooses, either  >> test.1.g
echo .I 't' minute >> test.1.g
echo timestamp or >> test.1.g
echo .I 'n' lines >> test.1.g
echo of logs. >> test.1.g
echo .IP -fs >> test.1.g
echo It filters all log files in folder and sub-folders in it. Folder path is given by user following >> test.1.g
echo .I '-fs' parameter  >> test.1.g
echo and generates logs based on what user chooses, either  >> test.1.g
echo .I 't' minute >> test.1.g
echo timestamp or >> test.1.g
echo .I 'n' lines >> test.1.g
echo .IP -a >> test.1.g
echo It appends previous log file if it exists. If   >> test.1.g
echo .I '-a' >> test.1.g
echo is not passed as an argument then Previous log file is  >> test.1.g
echo .I 'deleted' >> test.1.g
echo by default. >> test.1.g
echo .IP -z >> test.1.g
echo It changes new generated log file naming convention. By passing >> test.1.g
echo .I '-z' parameter  >> test.1.g
echo new log file is saved with timestamp in its name. >> test.1.g
echo .I  Eg:log_.yyyy-mm-dd.hh:mm.log >> test.1.g
echo .IP --h >> test.1.g
echo It Shows  >> test.1.g
echo .BR help >> test.1.g
echo option. >> test.1.g
echo .SH FILES >> test.1.g
echo .I {pwd}/log.properties >> test.1.g
echo .RS >> test.1.g
echo Contains default log file location and patters. You >> test.1.g
echo .BR register >> test.1.g
echo any log file in your directory and execute it with >> test.1.g
echo .I '-d' command. >> test.1.g
echo .SH ENVIRONMENT >> test.1.g
echo .IP logdebugg >> test.1.g
echo It do not affects any configuration. >> test.1.g
echo .SH BUGS >> test.1.g
echo The command name should have been chosen more carefully >> test.1.g
echo to reflect its purpose. >> test.1.g
echo .SH AUTHOR >> test.1.g
echo .BR RISHI  >> test.1.g
echo .BR ANAND  >> test.1.g
echo [ rishi.anand0@outlook.com ] >> test.1.g
echo .SH MENTOR >> test.1.g
echo .BR ZULFI  >> test.1.g
echo .BR AHAMED  >> test.1.g
echo [ Principal QA Engineer ] >> test.1.g
echo .SH "SEE ALSO" >> test.1.g
echo .BR grep, >> test.1.g
echo .BR egrep, >> test.1.g
echo .BR fgrep >> test.1.g


sudo cp test.1.g /usr/man/man1/logdebugg.1.gz
sudo rm -rf test.1.g

}

create_log_properties_file() {

	
		if [ ! -e "$log_property_file" ]
			then
				touch -- "$log_property_file"

				echo  >> $log_property_file
				echo log1=cd.log  >> $log_property_file
				echo log2=/var/log/vmware/vmware-usbarb-3360.log  >> $log_property_file
				echo log3=/var/log/glance/api.log  >> $log_property_file
				echo log4=/var/log/vmware/vmware-usbarb-721.log  >> $log_property_file
				echo log5=/var/log/glance/registry.log  >> $log_property_file
				echo log6=/var/log/keystone/keystone-all.log  >> $log_property_file
				echo log7=/var/log/keystone/keystone-manage.log  >> $log_property_file
				echo log8=/var/log/neutron/dhcp-agent.log  >> $log_property_file
				echo log9=/var/log/neutron/l3-agent.log >> $log_property_file
				echo log10=/var/log/neutron/metadata-agent.log  >> $log_property_file
				echo log11=/var/log/neutron/openvswitch-agent.log  >> $log_property_file
				echo log12=/var/log/neutron/ovs-cleanup.log  >> $log_property_file
				echo log13=/var/log/nova/nova-api.log  >> $log_property_file
				echo log14=/var/log/nova/nova-c2015-07-15ert.log  >> $log_property_file
				echo log15=/var/log/nova/nova-conductor.log  >> $log_property_file
				echo log16=/var/log/nova/nova-consoleauth.log  >> $log_property_file
				echo log17=/var/log/nova/nova-manage.log  >> $log_property_file
				echo log18=/var/log/nova/nova-novncproxy.log  >> $log_property_file
				echo log19=/var/log/nova/nova-compute.log  >> $log_property_file
				echo log20=/var/log/nova/nova-scheduler.log  >> $log_property_file
				echo log21=/var/log/openvswitch/ovs-ctl.log  >> $log_property_file
				echo log22=/var/log/openvswitch/ovsdb-server.log  >> $log_property_file
				echo log23=/var/log/openvswitch/ovs-vswitchd.log  >> $log_property_file
				echo log24=/var/log/rabbitmq/shutdown_err  >> $log_property_file
				echo log25=/var/log/rabbitmq/startup_err  >> $log_property_file
				echo log26=/var/log/rabbitmq/startup_log  >> $log_property_file
				echo log27=/var/log/rabbitmq/shutdown_log  >> $log_property_file
				echo log28=ab.log  >> $log_property_file
				echo log29=  >> $log_property_file
				echo log30=  >> $log_property_file
				echo log31=  >> $log_property_file
				echo log32=  >> $log_property_file
				echo log33=  >> $log_property_file
				echo log34=  >> $log_property_file
				echo log35=  >> $log_property_file
				echo log36=  >> $log_property_file
				echo log37=  >> $log_property_file
				echo log38=  >> $log_property_file
				echo log39=  >> $log_property_file
				echo log40=  >> $log_property_file
				echo log41=  >> $log_property_file
				echo log42=  >> $log_property_file
				echo log43=  >> $log_property_file
				echo log44=  >> $log_property_file
				echo log45=  >> $log_property_file
				echo log46=  >> $log_property_file
				echo log47=  >> $log_property_file
				echo log48=  >> $log_property_file
				echo log49=  >> $log_property_file
				echo log50=  >> $log_property_file

				echo  >> $log_property_file
				echo  >> $log_property_file
				echo  >> $log_property_file
				echo  >> $log_property_file
				
				echo   >> $log_property_file
                                echo   >> $log_property_file
                                echo   >> $log_property_file				
                                echo pattern1=  >> $log_property_file
				echo action_on_pattern1=  >> $log_property_file
				echo  >> $log_property_file
				echo pattern2=  >> $log_property_file
				echo action_on_pattern2=  >> $log_property_file
				echo  >> $log_property_file
				echo pattern3=  >> $log_property_file
				echo action_on_pattern3=  >> $log_property_file

				fi
}


if [ ! -e "$log_property_file" ];then
create_log_properties_file
else
. log.properties
fi

if [ ! -e "$man_file" ];then
create_man_page
fi


if [ $# -lt $EXPECTED_ARGS ]
then
show_commands
create_log_properties_file
exit $E_BADARGS
fi
##################ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ

# arguments : -d(default) : -p(path) : -t(timestamp) : -n(number of line) : -f(folder) 
# arguments : -fs(folder & sub-dir) : --h(help) : -a(append) : -z(file name with date)
for ((i=0;i<=$#;i++));
do echo "$#" "$i" "${!i}"; 
   
if [ "${!i}" = --h ] && [ "$#" -lt 2 ];then
echo --------------------------
echo \|   Execute : man logdebugg \|
echo --------------------------
show_commands
h_count="$i"
h_int="$i"
echo H $h_int 
fi

if [ "${!i}" = -d ];then
d_check=true
d_int="$i"
d_count="$i"
echo D $d_int
fi

if [ "${!i}" = -p ];then
p_check=true
p_int="$i"
echo P Check $p_int
fi

if [ "${!i}" = -t ];then
t_check=true
t_int="$i"
echo T $t_int
fi

if [ "${!i}" = -n ];then
n_check=true
n_int="$i"
echo N $n_int
fi

if [ "${!i}" = -f ];then
f_check=true
f_int="$i"
f_count="$i"
echo F $d_int
fi

if [ "${!i}" = -fs ];then
fs_check=true
fs_int="$i"
fs_count="$i"
echo FS $fs_int
fi

if [ "${!i}" = -a ];then
a_check=true
a_int="$i"
a_count="$i"
append_log=true
echo A $a_int
fi

if [ "${!i}" = -z ];then
z_check=true
z_int="$i"
z_count="$i"
log_file_name_with_date=true
echo log_file_name_with_date = $log_file_name_with_date
echo Z $z_int
fi


done

## TIMESTAMP ONLY
if [ "$t_check" = true ] && [ "$n_check" = false ];then
t_count=$t_int
((t_count=t_count+1))
re='^[0-9]+$'
   if ! [[ ${!t_count} =~ $re ]] ; then
   echo Parameter after -t is expected to be Integer.
   echo For More Help : man logdebugg
   echo Taking Default Timestamp : 5 min
   echo
   readmethod=t
   method=$readmethod
   echo Method is $method
   readcounter=5
   counter=$readcounter
   #echo Rishi $counter
   
   else 
   readmethod=t
   method=$readmethod
   echo Method is $method
   readcounter=${!t_count}
   counter=$readcounter
   #echo Rishi TimeStamp $counter
  fi
fi

## Number Of Lines ONLY
if [ "$t_check" = false ] && [ "$n_check" = true ];then
n_count=$n_int
echo Count of N is $n_count
((n_count=n_count+1))
re='^[0-9]+$'
   if ! [[ ${!n_count} =~ $re ]] ; then
   echo Parameter after -n is expected to be Integer.
   echo For More Help : man logdebugg
   echo Taking Default No. Of Lines : 50
   echo
   readmethod=n
   method=$readmethod
   echo Method is $method
   readcounter=5
   counter=$readcounter
   echo Rishi N $counter
   
   else 
   readmethod=n
   method=$readmethod
   echo Method is $method
   readcounter=${!n_count}
   counter=$readcounter
   echo Rishi No of Lines $counter
  fi
fi

## Only Defalut
if [ "$d_check" = true ] && [ "$p_check" = false ] && [ "$f_check" = false ] && [ "$fs_check" = false ];then
readconfigurelog=d
configurelog=$readconfigurelog
fi

## Only Path
if [ "$d_check" = false ] && [ "$p_check" = true ] && [ "$f_check" = false ] && [ "$fs_check" = false ];then
readconfigurelog=p
configurelog=$readconfigurelog
echo P Below $configurelog
ghjkl=55
echo ghkl $ghjkl
fi

## No Modes
if [ "$d_check" = false ] && [ "$p_check" = false ] && [ "$f_check" = false ] && [ "$fs_check" = false ];then
readconfigurelog=d
configurelog=$readconfigurelog
fi

## FOLDER MODES
if [ "$d_check" = false ] && [ "$p_check" = false ]  && [ "$f_check" = true ] && [ "$fs_check" = false ];then
readconfigurelog=f
configurelog=$readconfigurelog
fi

## FOLDER & SUB-FOLDER MODES
if [ "$d_check" = false ] && [ "$p_check" = false ]  && [ "$f_check" = false ] && [ "$fs_check" = true ];then
readconfigurelog=fs
configurelog=$readconfigurelog
fi

## ERROR MODES
if [ "$d_check" = true ] && [ "$p_check" = true ]  && [ "$f_check" = true ] && [ "$fs_check" = false ];then
#readconfigurelog=d
#configurelog=$readconfigurelog
   echo Illegal Parameter Passing
   echo For More Help : man logdebugg
   exit
fi

## ERROR MODES
if [ "$d_check" = true ] && [ "$p_check" = true ]  && [ "$f_check" = false ] && [ "$fs_check" = true ];then
#readconfigurelog=d
#configurelog=$readconfigurelog
   echo Illegal Parameter Passing
   echo For More Help : man logdebugg
   exit
fi

## ERROR MODES
if [ "$d_check" = true ] && [ "$p_check" = true ]  && [ "$f_check" = true ] && [ "$fs_check" = true ];then
#readconfigurelog=d
#configurelog=$readconfigurelog
   echo Illegal Parameter Passing
   echo For More Help : man logdebugg
   exit
fi

## ERROR MODES
if [ "$d_check" = false ] && [ "$p_check" = true ]  && [ "$f_check" = true ] && [ "$fs_check" = true ];then
#readconfigurelog=d
#configurelog=$readconfigurelog
   echo Illegal Parameter Passing
   echo For More Help : man logdebugg
   exit
fi

## ERROR MODES
if [ "$d_check" = false ] && [ "$p_check" = false ]  && [ "$f_check" = true ] && [ "$fs_check" = true ];then
#readconfigurelog=d
#configurelog=$readconfigurelog
   echo Illegal Parameter Passing
   echo For More Help : man logdebugg
   exit
fi


## ERROR MODES
if [ "$d_check" = false ] && [ "$p_check" = true ]  && [ "$f_check" = false ] && [ "$fs_check" = true ];then
#readconfigurelog=d
#configurelog=$readconfigurelog
   echo Illegal Parameter Passing
   echo For More Help : man logdebugg
   exit
fi


## ERROR MODES
if [ "$d_check" = false ] && [ "$p_check" = true ]  && [ "$f_check" = true ] && [ "$fs_check" = false ];then
#readconfigurelog=d
#configurelog=$readconfigurelog
   echo Illegal Parameter Passing
   echo For More Help : man logdebugg
   exit
fi


## ERROR MODES
if [ "$d_check" = true ] && [ "$p_check" = false ]  && [ "$f_check" = false ] && [ "$fs_check" = true ];then
#readconfigurelog=d
#configurelog=$readconfigurelog
   echo Illegal Parameter Passing
   echo For More Help : man logdebugg
   exit
fi

## ERROR MODES
if [ "$d_check" = false ] && [ "$p_check" = true ]  && [ "$f_check" = true ] && [ "$fs_check" = false ];then
#readconfigurelog=d
#configurelog=$readconfigurelog
   echo Illegal Parameter Passing
   echo For More Help : man logdebugg
   exit
fi

#array=(a c b f 3 5 1 2 z)
#qsort "${array[@]}"
#var=$(declare -p qsort_ret)
#echo $var
echo rishi
#if [ "$readconfigurelog" = p ];then

if [ "$configurelog" = p ]; then
   p_count=$p_int
   d_counter="$d_int"
   echo D_Counter "$d_counter"
   p_counter="$p_int"
   echo P_COUNTER "$p_counter"
   t_counter="$t_int"
   echo T_COUNTER $t_counter
   n_counter="$n_count"
   echo N_COUNTER $n_counter
   f_counter="$f_int"
   echo F_Counter $f_counter
   fs_counter="$fs_int"
   echo FS_COUNTER $fs_counter
   a_conuter="$a_int"
   echo A_COUNTER $a_counter
   z_counter="$z_int"
   echo Z_COUNTER $z_counter
   h_counter="$h_int"
   echo H_COUNTER $h_counter

#var=""
#array=("$d_counter" "$p_counter" "$t_counter" "$n_counter" "$f_counter" "$fs_counter" "$a_counter" "$z_counter" "$h_counter")
#qsort "${array[@]}"
#echo while-

((p_count=p_count+1))
last="$#"
((last=last+1))
   while [ "$p_count" -ne "$d_counter" ] && [ "$p_count" -ne "$last" ] && [ "$p_count" -ne "$t_counter" ] && [ "$p_count" -ne "$n_counter" ] && [ "$p_count" -ne "$f_counter" ] && [ "$p_count" -ne "$fs_counter" ] && [ "$p_count" -ne "$a_counter" ] && [ "$p_count" -ne "$z_counter" ] && [ "$p_count" -ne "$h_counter" ] 
   do
   i=1
    logfiles=( "${logfiles[@]}" "${!p_count}" )
   
   ((p_count=p_count+1))
   done

fi

	 
if [ "$log_file_name_with_date" = true ];then
   filetobewritten=$filenamewithdate
fi

if [ "$log_file_name_with_date" = false ];then
   filetobewritten=$filenamewithoutdate
fi

echo log $log1
echo log $log2





#ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ

# Change Line Number value according to your need.
counter=$readcounter





echo #--------------------------- Creating File -------------------------- Creating File -------------------------------------------

	directory=$(pwd)
hostname=$(hostname)

#	if [ "$configurelog" != p ] && [ "$configurelog" != f ] && [ "$configurelog" != fs ] && [ "$configurelog" != d ]; then

	if [ "$method" = t ] || [ "$method" = n ] || [ "$method" = fn ] || [ "$method" = ft ]; then

echo Inside method  rishi 
	     if [ ! -e "$filetobewritten" ]
	then
     echo Creating Log above Rishi = $append_log
	touch -- "$filetobewritten"

	echo  >> $filetobewritten
	echo -##----------------------------------------------------------------------------------------------------------------## >> $filetobewritten
	echo -# . . . . . . . . . . . . . . . .. . . .--==* LOG FILE DEBUGGER *==--. . . . . . . . . . . . . . . . . . . . . . .-# >> $filetobewritten
	echo - . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . - >> $filetobewritten
	echo - . . . . . . . . . . . . . . . . . . . . . . . . .  . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .- >> $filetobewritten
	echo -#. . . . . . . . . . . . .  . . . [ RISHI ANAND l +91 82678-46255 l rishi@cliqr.com ] . . . . . . . . . . . . . . -# >> $filetobewritten
	echo -##----------------------------------------------------------------------------------------------------------------## >> $filetobewritten
	echo  >> $filetobewritten
	echo =================== Below Log is from Computer Name : $hostname =================== >> $filetobewritten 
	echo -------
	echo Creating New Log file : $directory/$filetobewritten
	echo ------- 
	  fi


        if [ -s "$filetobewritten" ] && [ "$append_log" = true ]
	then
            echo Append Log Rishi = $append_log
            echo =================== Below Log is from Computer Name : $hostname =================== >> $filetobewritten
	    echo -------
	    echo Appending Previous Log file : $directory/$filetobewritten
	    echo ------- 
        fi
        if [ -s "$filetobewritten" ] && [ "$append_log" = false ]
            then  
            
	    rm -rf $filetobewritten
            touch -- "$filetobewritten"
   echo Creating Log Rishi = $append_log

	echo  >> $filetobewritten
	echo -##----------------------------------------------------------------------------------------------------------------## >> $filetobewritten
	echo -# . . . . . . . . . . . . . . . .. . . .--==* LOG FILE DEBUGGER *==--. . . . . . . . . . . . . . . . . . . . . . .-# >> $filetobewritten
	echo - . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . - >> $filetobewritten
	echo - . . . . . . . . . . . . . . . . . . . . . . . . .  . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .- >> $filetobewritten
	echo -#. . . . . . . . . . . . .  . . . [ RISHI ANAND l +91 82678-46255 l rishi@cliqr.com ] . . . . . . . . . . . . . . -# >> $filetobewritten
	echo -##----------------------------------------------------------------------------------------------------------------## >> $filetobewritten
	echo  >> $filetobewritten
	echo =================== Below Log is from Computer Name : $hostname =================== >> $filetobewritten 
	echo -------
	echo Creating New Log file : $directory/$filetobewritten
	echo -------
            
	    fi
            
       fi
       

	echo #--------------------------- Creating File -------------------------- Creating File -------------------------------------------









######### LOG FILES ######### LOG FILES ######### LOG FILES ######### LOG FILES ######### LOG FILES ######## LOG FILES ######## LOG FILES #####

# --------[DEFAULT]-------[DEFAULT]------------ Update your parameters below below this line --------[DEFAULT]-------[DEFAULT]------------
echo configurelog = $configurelog
	if [ "$configurelog" = d ];then

	declare -a logfiles=("$log1" "$log2" "$log3" "$log4" "$log5" "$log6" "$log7" "$log8" "$log9" "$log10" "$log11" "$log12" "$log13" "$log14" "$log15" "$log16" "$log17" "$log18" "$log19" "$log20" "$log21" "$log22" "$log23" "$log24" "$log25" "$log26" "$log27" "$log28" "$log29" "$log30" "$log31" "$log32" "$log33" "$log34" "$log35" "$log36" "$log37" "$log38" "$log39" "$log40" "$log41" "$log42" "$log43" "$log44" "$log45" "$log46" "$log47" "$log48" "$log49" "$log50")


	fi
# --------[DEFAULT]-------[DEFAULT]------------ Update your parameters above below this line --------[DEFAULT]-------[DEFAULT]------------


# --------[USER INPUT= FOLDER]-------[USER INPUT]------------ Below Parameter gets added automatically --------[USER INPUT]-----[USER INPUT]-------

	if [ "$configurelog" = fs ];then
	allfilesinfolder=$(find $folder -type f -exec echo "{}" \;)
	fi
# --------[USER INPUT]-------[USER INPUT]------------ Below Parameter gets added automatically --------[USER INPUT]-----[USER INPUT]-------


######### LOG FILES ######### LOG FILES ######### LOG FILES ######### LOG FILES ######### LOG FILES ######## LOG FILES ######## LOG FILES #####









############# METHOD : No OF LINE [STARTS] ########### METHOD : No OF LINE [STARTS] ########### METHOD : No OF LINE [STARTS] ############### 

	if [ "$method" = n ];then
	numberoflines=$counter

echo inside N

	for i in "${logfiles[@]}"
       
	do
	if [ -e "$i" ]; then

	sudo echo ==== >> $filetobewritten
	sudo echo ==== >> $filetobewritten
	sudo echo ==== >> $filetobewritten
	sudo echo -------------------------------- "$i" ------------------------------------>> $filetobewritten
	sudo echo ==== >> $filetobewritten
	echo "$i"


	sudo tail -n $numberoflines "$i" | while read line ; do
	sudo echo "$line" >> $filetobewritten



#---------------------- Below Line of code will search for a pattern and echo it on screen with line number -----------------------------#
#----------- You can also bind specific pattern with specific operation , or you can also create new pattern and new operation -------------#

# check each line against our pattern ,if a line matches... , send an email!

	sudo echo "$line" | grep -i "$pattern1"
	if [ $? = 0 ]; then
	sudo echo "Found an error: $line" | mail $email -s ERROR on $hostname
	sudo echo ERROR#######ERROR######ERROR########ERROR#######ERROR######ERROR#######ERROR#######ERROR###### >> $filetobewritten

	fi
	sudo echo "$line" | grep -i "$pattern2"
	if [ $? = 0 ]; then
	sudo echo "Found an error: $line" | mail $email -s ERROR on $hostname
	sudo echo ERROR#######ERROR######ERROR########ERROR#######ERROR######ERROR#######ERROR#######ERROR###### >> $filetobewritten

	fi
	sudo echo "$line" | grep -i "$pattern3"
	if [ $? = 0 ]; then
	sudo echo "Found an error: $line" | mail $email -s ERROR on $hostname
	sudo echo ERROR#######ERROR######ERROR########ERROR#######ERROR######ERROR#######ERROR#######ERROR###### >> $filetobewritten

	fi
#---------------------------------- Above Line of code will search for a pattern and echo it on screen with line number ----------------------


	done
	fi
	done
	fi

############# METHOD : No OF LINE [ENDS] ########### METHOD : No OF LINE [ENDS] ########### METHOD : No OF LINE [ENDS] ###############







######### METHOD : TIMESTAMP ########### METHOD : TIMESTAMP ########### METHOD : TIMESTAMP ########### METHOD : TIMESTAMP ###########
	if [ "$method" = t ];then

	check=false

#echo Enter Time from which your log will be collected [-in minutes] 
# echo Eg: If input is 5 then, All logs will be shown that are touched after 5 minutes
#  read usergiventime

	time=$counter


	directory=$(pwd)
hostname=$(hostname)

	echo ----- Computer Name : $hostname ------

	current_time=$(date +'%Y-%m-%d %H:%M')
	revisedtime=$(date -d "$time min ago" +'%Y-%m-%d %H:%M')
	echo current time = $current_time
	echo revisedtime = $revisedtime



	for i in "${logfiles[@]}"

	do

	if [ -e "$i" ]; then
	echo ==== >> $filetobewritten
	echo ==== >> $filetobewritten
	sudo echo ==== >> $filetobewritten
	sudo echo -------------------------------- "$i" ------------------------------------ >> $filetobewritten
	sudo echo ==== >> $filetobewritten
	echo File : "$i"


	check=false
	time=$counter
	while [ $time -gt -1 ] && [ "$check" = false ] 
	do

	check=true
	revisedtime=$(date -d "$time min ago" +'%Y-%m-%d %H:%M')
	sudo grep "$revisedtime" -A 50000 -B 0 "$i" || check=false
((time=time-1))    

	done

	sudo grep "$revisedtime" -A 50000 -B 0 "$i" | while read line ; do

# Comment above line and remove comment from below line when you want to get LOGS of n Number of Lines.

# Comment below line and remove comment from above line when you want to get LOGS based on TIME-STAMP.
# Default is logs based on TIME-STAMP

#sudo tail -n $counter "$i" | while read line ; do
	sudo echo "$line" >> $filetobewritten



###--------------- Below Line of code will search for a pattern and echo it on screen with line number --------------------###
### ------You can also bind specific pattern with specific operation , or you can also create new pattern and new operation  --------###

# check each line against our pattern ,if a line matches... , send an email!

	sudo echo "$line" | grep -i "$pattern1"
	if [ $? = 0 ]; then
	sudo echo "Found an error: $line" | mail $email -s ERROR_on_$hostname
	sudo echo ERROR####### ERROR###### ERROR######## ERROR####### ERROR###### ERROR####### ERROR####### ERROR >> $filetobewritten

	fi
	sudo echo "$line" | grep -i "$pattern2"
	if [ $? = 0 ]; then
	sudo echo "Found an error: $line" | mail $email -s ERROR_on_$hostname
	sudo echo ERROR#######ERROR######ERROR########ERROR#######ERROR######ERROR#######ERROR#######ERROR >> $filetobewritten

	fi
	sudo echo "$line" | grep -i "$pattern3"
	if [ $? = 0 ]; then
	sudo echo "Found an error: $line" | mail $email -s ERROR_on_$hostname
	sudo echo ERROR#######ERROR######ERROR########ERROR#######ERROR######ERROR#######ERROR#######ERROR >> $filetobewritten

	fi


#-------------------- Above Line of code will search for a pattern and echo it on screen with line number -----------------------#


	done
	fi
	done
	fi


######### METHOD : TIMESTAMP [ENDS] ########### METHOD : TIMESTAMP [ENDS] ########### METHOD : TIMESTAMP [ENDS] ###########TIMESTAMP #######






############# FOLDER-METHOD : No OF LINE [STARTS] ########### FOLDER-METHOD : No OF LINE [STARTS] ########### FOLDER-METHOD : No OF LINE [STARTS] ############### 

	if [ "$method" = fn ];then
	numberoflines=$counter



#allfilesinfolder=$(find $folder -type f -exec echo "{}" \;)

	for i in $allfilesinfolder

	do
	if [ -e "$i" ]; then
	sudo echo ==== >> $filetobewritten
	sudo echo ==== >> $filetobewritten
	sudo echo ==== >> $filetobewritten
	sudo echo -------------------------------- "$i" ------------------------------------>> $filetobewritten
	sudo echo ==== >> $filetobewritten
	echo "$i"


	sudo tail -n $numberoflines "$i" | while read line ; do
	sudo echo "$line" >> $filetobewritten



#---------------------- Below Line of code will search for a pattern and echo it on screen with line number -----------------------------#
#----------- You can also bind specific pattern with specific operation , or you can also create new pattern and new operation -------------#

# check each line against our pattern ,if a line matches... , send an email!

	sudo echo "$line" | grep -i "$pattern1"
	if [ $? = 0 ]; then
	sudo echo "Found an error: $line" | mail $email -s ERROR on $hostname
	sudo echo ERROR#######ERROR######ERROR########ERROR#######ERROR######ERROR#######ERROR#######ERROR###### >> $filetobewritten

	fi
	sudo echo "$line" | grep -i "$pattern2"
	if [ $? = 0 ]; then
	sudo echo "Found an error: $line" | mail $email -s ERROR on $hostname
	sudo echo ERROR#######ERROR######ERROR########ERROR#######ERROR######ERROR#######ERROR#######ERROR###### >> $filetobewritten

	fi
	sudo echo "$line" | grep -i "$pattern3"
	if [ $? = 0 ]; then
	sudo echo "Found an error: $line" | mail $email -s ERROR on $hostname
	sudo echo ERROR#######ERROR######ERROR########ERROR#######ERROR######ERROR#######ERROR#######ERROR###### >> $filetobewritten

	fi
#---------------------------------- Above Line of code will search for a pattern and echo it on screen with line number ----------------------


	done
	fi
	done
	fi

############# FOLDER-METHOD : No OF LINE [ENDS] ########### FOLDER-METHOD : No OF LINE [ENDS] ########### FOLDER-METHOD : No OF LINE [ENDS] ###############






######### FOLDER-METHOD : TIMESTAMP [START] ########### FOLDER-METHOD : TIMESTAMP [START] ########### FOLDER-METHOD : TIMESTAMP [START] ########### FOLDER-METHOD : TIMESTAMP [START] ###########


	if [ "$method" = ft ];then
	echo Inside Method T
	check=false

#echo Enter Time from which your log will be collected [-in minutes] 
# echo Eg: If input is 5 then, All logs will be shown that are touched after 5 minutes
#  read usergiventime

	time=$counter

	current_time=$(date +'%Y-%m-%d %H:%M')
	revisedtime=$(date -d "$time min ago" +'%Y-%m-%d %H:%M')
	echo current time = $current_time
	echo revisedtime = $revisedtime


	directory=$(pwd)
hostname=$(hostname)

	echo ----- Computer Name : $hostname ------

	current_time=$(date +'%Y-%m-%d %H:%M')
	revisedtime=$(date -d "$time min ago" +'%Y-%m-%d %H:%M')
	echo current time = $current_time
	echo revisedtime = $revisedtime






	for i in $allfilesinfolder

	do

	if [ -e "$i" ]; then
	sudo echo ==== >> $filetobewritten
	sudo echo ==== >> $filetobewritten
	sudo echo ==== >> $filetobewritten
	sudo echo -------------------------------- "$i" ------------------------------------ >> $filetobewritten
	sudo echo ==== >> $filetobewritten
	echo File : "$i"


	check=false
	time=$counter
	while [ $time -gt -1 ] && [ "$check" = false ] 
	do

	check=true
	revisedtime=$(date -d "$time min ago" +'%Y-%m-%d %H:%M')
	sudo grep "$revisedtime" -A 50000 -B 0 "$i" || check=false
((time=time-1))    

	done

	sudo grep "$revisedtime" -A 50000 -B 0 "$i" | while read line ; do

# Comment above line and remove comment from below line when you want to get LOGS of n Number of Lines.

# Comment below line and remove comment from above line when you want to get LOGS based on TIME-STAMP.
# Default is logs based on TIME-STAMP

#sudo tail -n $counter "$i" | while read line ; do
	sudo echo "$line" >> $filetobewritten



###--------------- Below Line of code will search for a pattern and echo it on screen with line number --------------------###
### ------You can also bind specific pattern with specific operation , or you can also create new pattern and new operation  --------###

# check each line against our pattern ,if a line matches... , send an email!

	sudo echo "$line" | grep -i "$pattern1"
	if [ $? = 0 ]; then
	sudo echo "Found an error: $line" | mail $email -s ERROR_on_$hostname
	sudo echo ERROR####### ERROR###### ERROR######## ERROR####### ERROR###### ERROR####### ERROR####### ERROR >> $filetobewritten

	fi
	sudo echo "$line" | grep -i "$pattern2"
	if [ $? = 0 ]; then
	sudo echo "Found an error: $line" | mail $email -s ERROR_on_$hostname
	sudo echo ERROR#######ERROR######ERROR########ERROR#######ERROR######ERROR#######ERROR#######ERROR >> $filetobewritten

	fi
	sudo echo "$line" | grep -i "$pattern3"
	if [ $? = 0 ]; then
	sudo echo "Found an error: $line" | mail $email -s ERROR_on_$hostname
	sudo echo ERROR#######ERROR######ERROR########ERROR#######ERROR######ERROR#######ERROR#######ERROR >> $filetobewritten

	fi


#-------------------- Above Line of code will search for a pattern and echo it on screen with line number -----------------------#


	done
	fi
	done
	fi


######### METHOD : TIMESTAMP [ENDS] ########### METHOD : TIMESTAMP [ENDS] ########### METHOD : TIMESTAMP [ENDS] ###########TIMESTAMP #######





	exit
