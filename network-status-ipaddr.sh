#!/bin/sh

ipaddr=`ifconfig wlp3s0 | awk '/inet / {gsub(" ", "", $2); print $2}'`

echo $ipaddr

exit 0
