#!/bin/bash
status=$(cat /sys/class/power_supply/max1726x_battery/capacity | bc)
status=$((bc -l $status))
echo $status
level="0"
if [ [$status -gt "0.0"] ]
then
  if [ $status -gt "25.0" ]
  then
    level="25"
    if [ $status -gt "50.0" ]
    then
      level="50"
      if [ $status -gt "75.0" ]
      then
        level="75"
        if [ $status -gt "95.0" ]
        then
          level="100"
        fi
      fi
    fi
  fi
fi


echo $level


command="./pngview /home/pi/kelboy-launcher/resources/graphics/battery-$level.png -b 0 -l 300003 -x 290 -y 7 &"
old=$(cat battery.old)
if [ "$status" != "$old" ]
then
  echo "refreshing battery status: $command"
  sudo killall -9 pngview
  $command
  #now wait for refresh
  #pid=$(ps -aux | grep -i pngview | awk '{print $2}')
  #command2="kill -9 $pid"
fi
echo "$status" > battery.old
rm 0
sleep 9
./battery.sh &

$command
