#! /bin/bash

## Records the room ambient noise amplitude through the defualt microphone

RECORDTIME=10
arecord -f cd ~/roomnoise.wav -d $RECORDTIME

NORMLINE=$(sox ~/roomnoise.wav -n stat 2>&1 | grep norm)

NORM=${NORMLINE//[!0-9]/}

# With heater: ~600
# Without heater: ~380?
VOL=$(echo "($NORM / 10) * 2 - 55" | bc)
VOLMAXED=$(($VOL<55?$VOL:55))
VOLMAXEDMINNED=$(($VOLMAXED>42?$VOLMAXED:42))
echo $VOLMAXEDMINNED
