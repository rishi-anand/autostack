#!/bin/bash

CONFIGFILE="property.txt"
echo "=$ADMIN= =$TODO= =$FILE=" #these variables are not defined here
eval $(sed '/:/!d;/^ *#/d;s/:/ /;' < "$CONFIGFILE" | while read -r key val
do
    #verify here
    #...
    str="$key='$val'"
    echo "$str"
done)
echo =$ADMIN= =$TODO= =$FILE= #here are defined

exit
