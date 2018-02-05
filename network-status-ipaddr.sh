#!/bin/sh

iwconfig wlp3s0 2>&1 | grep -q no\ wireless\ extensions\. && {
    echo wired
    exit 0
}

ipaddr=`ifconfig wlp3s0 | awk '/inet / {gsub(" ", "", $2); print $2}'`

echo $ipaddr

exit 0
