#!/bin/bash
. rishi.properties
. a.properties
echo $name
echo $age
echo $counter
#echo $service_name
echo enter name
read nameis

#sed "s/name=.*/abcd=$nameis/g" rishi.properties > tmp
#mv tmp rishi.properties

awk 'BEGIN { FS = "="; OFS = "=" } $1 == "name" { print $1, "new value"; next } 1' < rishi.properties > rishi.properties


#sed "s/name=.*/name=$nameis/g" rishi.properties > tmp
#mv tmp rishi.properties


echo chnged name is $name

#conn=$username$password$service_name
#echo $conn
