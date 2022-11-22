#! /bin/bash

fcitx5 &
nm-applet &
flameshot &
feh --bg-fill ~/wallpaper/04.png
picom --config ~/.dwm/scripts/picom.conf & 

while true
do
  bash ~/.dwm/scripts/statusbar.sh &
  sleep 1
done 
