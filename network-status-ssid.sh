#!/bin/sh

essid=`nmcli | awk '/connected to/ {print $4}'`

echo $essid

exit 0
