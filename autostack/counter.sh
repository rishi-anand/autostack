#!/bin/bash


. ~/open/linecounterfiles/controller.properties

today=`date +%Y-%m-%d.%H:%M:%S`
#controllerone=1
check=true
filename=`basename "$0"`

echo enter

echo $controllerone


exec 2> >(tee "somefile.$today.err")
exec > >(tee "somefile.$today.log")



# Define your function here
line_counter_increment () {

   sed "s/controllerone=.*/controllerone=$1/g" ~/open/linecounterfiles/controller.properties > tmp
   mv tmp ~/open/linecounterfiles/controller.properties
  echo increasing $1
  #return $controllerone
}

#line_counter_increment 1
echo controllir is $controllerone

if [ "$check" = true ] && [ $controllerone -eq 1 ] ; then

cd || check=false 
 

echo -------------------$filename line 1 no : $controllerone------------------------
#line_counter_increment 2
fi


echo controllir is $controllerone
if [ "$check" = true ] && [ $controllerone -eq 2 ] ; then


apt-get update || (check=false && echo nok )
echo -------------------$filename line 2 no : $controllerone------------------------
#line_counter_increment 3
fi

echo controllir is $controllerone


if [ "$check" = true ] && [ $controllerone -eq 3 ] ; then
#((controllerone=controllerone+1))
cd || check=false 
echo -------------------$filename line 3 no : $controllerone------------------------
#line_counter_increment 4
fi


echo $controllerone
check=true
if [ "$check" = true ] && [ $controllerone -eq 4 ] ; then
#((controllerone=controllerone+1))
cd || check=false 
echo -------------------$filename line 4 no : $controllerone------------------------
#line_counter_increment 5
fi


echo $controllerone

if [ "$check" = true ] && [ $controllerone -eq 5 ] ; then
#((controllerone=controllerone+1))
cd || check=false 
echo -------------------$filename line 5 no : $controllerone------------------------
#line_counter_increment 6
fi



exit
