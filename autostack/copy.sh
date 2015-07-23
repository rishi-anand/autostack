#!/bin/bash



source=~/log_file/
destination=/home/one/

if [ ! -d "$destination" ]; then
    mkdir -p "$destination"
fi
sudo cp -R "$source" "$destination"



find ~/pullstack/ -type f -print0 | xargs -0 sed -i 's/SWATILOVESRISHI/RISHI/g'



cat /home/rishi/pullstack/createdbyown/createdbyown/ab.properties

#cat /home/rishi/pullstack/createdbyown/createdbyown (3rd copy)/createdbyown/createdbyown (another copy)
