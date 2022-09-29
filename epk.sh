#!/bin/bash
x=x
while [[ $x == x ]]; do
p=$( ps aux | grep thumbshot.py | grep -v grep | grep -o python3 | tail -1 )
if [[ $p = python3 ]]; then
export DISPLAY=:0
qdbus org.kde.KWin /KWin setCurrentDesktop 1
xrandr --output DP-3 --brightness 1.4
~/.epk/epko.sh
fi
sleep 0.2
done
