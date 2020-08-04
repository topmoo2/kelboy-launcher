#!/bin/bash

status=$(cat /sys/class/power_supply/max1726x_battery/capacity)
level = "0"
if [ $status>0 ]
then
  if [ $status > 25 ]
  then
    level="25"
    if [ $status > 50 ]
    then
      level="50"
      if [ $status > 75 ]
      then
        level="75"
        if [ $status > 95 ]
        then
          level="100"
        fi
      fi
    fi
  fi
fi

exitCode=$("./pngview '../resources/graphics/battery-$level.png' -b 0 -l 300003 -x 300 -y 5")

echo "done!"