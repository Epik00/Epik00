#!/bin/bash
x=x
timer=250

while [[ $x == x ]]; do
p=$( ps aux | grep thumbshot.py | grep -v grep | grep -o python3 | tail -1 )
if [[ $p = python3 ]]; then
timer=250
else
timer=$(($timer - 1 ))

fi
sleep 0.2
if [[ $timer < 1 ]]; then
export DISPLAY=:0
xrandr --output DP-3 --brightness 1
exit
fi
done

