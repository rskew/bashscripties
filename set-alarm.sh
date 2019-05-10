#! /usr/bin/env bash

# Usage for wakeup.sh
##  systemd-run --user --on-calendar="Mon 2017-05-08 23:53:00 AEST" wakeup.sh

# Stop with
## systemctl --user stop _unit_id_
# (get the unit_it from 'systemctl --user list-timers', globs ok)

systemd-run --user --on-calendar="$1" wakeup.sh
