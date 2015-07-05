#!/bin/bash
 
# Check the parameters
if [ $# -ne 1 ]
then
  echo -e "Usage: ${0} prop.txt"
  exit 1
else
  CONF_FILE=$1
fi
 
echo -e "Starting script $0\n";
 
# Read config file and assign values
 
for i in `cat $CONF_FILE | grep '^[^#].*'`
do
   var=`echo "$i" | awk -F"=" '{print $1}'`
   param=`echo "$i" | awk -F"=" '{print $2}'`
   eval $var=$param
done
 
# Print a sample valeue
echo $DB_Name
 
echo -e "Script $0 Finished\n";
