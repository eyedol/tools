#!/bin/sh
##This scrit is to check fetchmail process if it's dead,run fetchmail
# Put this in a crontab
while true
do
   pal=`pgrep fetchmail | wc -l`

   if [ $pal = "0" ]
   then
      fetchmail -v > /dev/null &
   fi

   sleep 1
done