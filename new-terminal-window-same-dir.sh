#! /bin/bash
echo $PWD
i3-msg "exec urxvt -cd \"$PWD\""
