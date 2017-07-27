#! /bin/bash

cd /sys/class/backlight/intel_backlight/

current=$(cat ./actual_brightness)

currentindex=$(echo "((l($current + 1) * 30) / l(4648))" | bc -l)
scaledindex=$(echo "(($currentindex - 1)*l(4648))/30" | bc -l)

newval=$(echo "e($scaledindex)-1" | bc -l)
newval=$( echo $newval | cut -f1 -d"." )

if [ $newval -ge 30 ]; then
	    tee ./brightness <<< $newval
else
    if [ $current -ge 0 ]; then
        tee ./brightness <<< $(echo "$current - 1" | bc -l)
    else
        tee ./brightness <<< 0
    fi
fi
