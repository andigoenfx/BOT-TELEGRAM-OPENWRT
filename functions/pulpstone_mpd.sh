#!/bin/sh
pulpstone_mpd=15-03-2018
case $1 in
"mpd_play")
  mpc play > /tmp/mpd_bot.log
  mpc current > /tmp/mpd_bot.log
  mpdc=$(cat /tmp/mpd_bot.log)
  /usr/bin/mpc | grep volume | awk -F "%" '{print $1}'  > /tmp/mpd_bot.txt
  mpdvol=$(cat /tmp/mpd_bot.txt | awk '{print $2}')
  echo -e "$mpdc \nVolume $mpdvol"
  ;;
"mpd_stop")
  mpc stop  > /dev/null
  echo -e "STOP"
  ;;
"mpd_current")
  mpc current > /tmp/mpd_bot.log
  mpdc=$(cat /tmp/mpd_bot.log)
  /usr/bin/mpc | grep volume | awk -F "%" '{print $1}'  > /tmp/mpd_bot.txt
  mpdvol=$(cat /tmp/mpd_bot.txt | awk '{print $2}')
  echo -e "$mpdc \nVolume $mpdvol"
  ;;
"mpd_vol_up")
  mpc volume +5 > /tmp/mpd_bot.log
  mpc current > /tmp/mpd_bot.log
  mpdc=$(cat /tmp/mpd_bot.log)
  /usr/bin/mpc | grep volume | awk -F "%" '{print $1}'  > /tmp/mpd_bot.txt
  mpdvol=$(cat /tmp/mpd_bot.txt | awk '{print $2}')
  echo -e "$mpdc \nVolume $mpdvol"
  ;;
"mpd_vol_down")
  mpc volume -5 > /tmp/mpd_bot.log
  mpc current > /tmp/mpd_bot.log
  mpdc=$(cat /tmp/mpd_bot.log)
  /usr/bin/mpc | grep volume | awk -F "%" '{print $1}'  > /tmp/mpd_bot.txt
  mpdvol=$(cat /tmp/mpd_bot.txt | awk '{print $2}')
  echo -e "$mpdc \nVolume $mpdvol"
  ;;
"mpd_next")
  mpc next > /tmp/mpd_bot.log
  sleep 3
  mpc current > /tmp/mpd_bot.log
  mpdc=$(cat /tmp/mpd_bot.log)
  /usr/bin/mpc | grep volume | awk -F "%" '{print $1}'  > /tmp/mpd_bot.txt
  mpdvol=$(cat /tmp/mpd_bot.txt | awk '{print $2}')
  echo -e "$mpdc \nVolume $mpdvol"
  ;;
"mpd_prev")
  mpc prev > /tmp/mpd_bot.log
  sleep 3
  mpc current > /tmp/mpd_bot.log
  mpdc=$(cat /tmp/mpd_bot.log)
  /usr/bin/mpc | grep volume | awk -F "%" '{print $1}'  > /tmp/mpd_bot.txt
  mpdvol=$(cat /tmp/mpd_bot.txt | awk '{print $2}')
  echo -e "$mpdc \nVolume $mpdvol"
  ;;
"mpd")
  ls /usr/bin/ |grep mpc
  if [ $? == 0 ];then
    echo -e "Available /mpd: \n\n/mpd_play \n/mpd_current \n/mpd_stop \n/mpd_next \n/mpd_prev \n/mpd_vol_up \n/mpd_vol_down \n\nBack: /list"
  else
    echo -e "Install MPD first!"
  fi
  ;;

  *)
    echo -e "List of MPD Commands \n/mpd"
;;
esac
