#! /bin/bash

## Need to make /sys/class/backlight/intel_backlight/brightness
##  writable, run as root or add brightness file to sudoers NOPASSWRD

cd /sys/class/backlight/intel_backlight/ 

current=$(cat ./actual_brightness)

currentindex=$(echo "((l($current + 1) * 30) / l(4648))" | bc -l)
echo $currentindex
scaledindex=$(echo "(($currentindex + 1)*l(4648))/30" | bc -l)

newval=$(echo "e($scaledindex)-1" | bc -l)
newval=$( echo $newval | cut -f1 -d"." )
echo $newval

max=$(cat ./max_brightness)

if [ $current -le 40 ]; then
    tee ./brightness <<< $( echo "$current + 1" | bc -l)
else
    if [ $newval -le $max ]; then
	    tee ./brightness <<< $newval
    else
        tee ./brightness <<< 4648
    fi
fi
