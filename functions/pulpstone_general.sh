#!/bin/sh
pulpstone_general=17-03-2018
case $1 in  
"network_traffic")
  ipad=$(grep internet_source /root/pulpstone_bot/pulpstone_bot.conf |awk -F"=" '{print $2}')
  RX=$(ifconfig $ipad | awk -F[\(\)] '/bytes/ {printf "%s",$2}' |sed -e 's/[\t ]//g;s/i//g')
  TX=$(ifconfig $ipad | awk -F[\(\)] '/bytes/ {printf "%s",$4}' |sed -e 's/[\t ]//g;s/i//g')
  MACH=$(cat /tmp/sysinfo/model)
  U=$(cut -d. -f1 /proc/uptime)
  D=$(expr $U / 60 / 60 / 24)
  H=$(expr $U / 60 / 60 % 24)
  M=$(expr $U / 60 % 60)
  S=$(expr $U % 60)
  U=$(printf "%dd, %02d:%02d:%02d" $D $H $M $S)
  echo -e "$MACH \nUptime $U \nDownload $RX \nUpload $TX"
  ;;
"temp")
  degree=$(echo $'\xc2\xb0'C)
  mydevice=$(grep my_device /root/pulpstone_bot/pulpstone_bot.conf |awk -F"=" '{print $2}')
  if [ "$mydevice" == "raspi" ];then
    temp="$(cat /sys/devices/virtual/thermal/thermal_zone0/temp)"
    temp=$(($temp/1000))   #raspi
	echo -e "Raspberry Pi Temperature: $temp$degree"
  elif [ "$mydevice" == "orangepizero" ];then
    temp="$(cat /sys/devices/virtual/thermal/thermal_zone0/temp)" #chaoscalmer-opiz
	echo -e "OrangePi Zero Temperature: $temp$degree"
  elif [ "$mydevice" == "nonsbc" ];then
    echo -e "not support" #nonsbc
  fi
  ;;
"myip")
  myip=$(curl ipecho.net/plain 2> /dev/null)
  echo -e "$myip"
  ;;
"3g_info")
  u3gf=$(grep 3g_info /root/pulpstone_bot/pulpstone_bot.conf |awk -F"=" '{print $2}')
  if [ "$u3gf" == "yes" ];then
    3ginfo 2> /dev/null > /tmp/3ginfotmp
 modem=$(grep Device /tmp/3ginfotmp | cut -d':' -f 2 | sed -e 's/^[ \t]*//' 2> /dev/null)
 contim=$(grep Connection /tmp/3ginfotmp | awk '{print $3,$4}' | sed 's/ //g' 2> /dev/null)
 txx=$(grep Transmitted /tmp/3ginfotmp | cut -d':' -f 2 | sed -e 's/^[ \t]*//' 2> /dev/null)
 opsel=$(grep Operator /tmp/3ginfotmp | cut -d':' -f 2 | sed -e 's/^[ \t]*//' 2> /dev/null)
 mosel=$(grep Operating /tmp/3ginfotmp | cut -d':' -f 2 | sed -e 's/^[ \t]*//' 2> /dev/null)
 sgsel=$(grep strength /tmp/3ginfotmp | cut -d':' -f 2 | sed -e 's/^[ \t]*//' 2> /dev/null)
 echo -e "Modem: $modem \nConnection Time: $contim \nMobile Data: $txx \nOperator: $opsel \nCellular Network: $mosel \nSignal Strength: $sgsel"
  else
    echo -e "Not use 3G/4G Info"
  fi
  ;;
"transmission")
  ls /usr/bin/ |grep transmission-remote &> /dev/null
  if [ $? == 0 ];then
    echo -e "Available /transmission: \n\n/transmission_list \n/transmission_statistics \n/transmission_active \n\nBack: /list"
  else
    echo -e "Install Torrent Transmission first!"
  fi
  ;;
"transmission_list")
  t_usr=$(cat /etc/config/transmission |grep rpc_username |awk -F"'" '{print $2}')
  t_pass=$(cat /etc/config/transmission |grep rpc_password |awk -F"'" '{print $2}')
  t_clients=$(transmission-remote -n $t_usr:$t_pass -l |sed 's/%//g')
  echo -e "$t_clients"
  ;;
"transmission_statistics")
  t_usr=$(cat /etc/config/transmission |grep rpc_username |awk -F"'" '{print $2}')
  t_pass=$(cat /etc/config/transmission |grep rpc_password |awk -F"'" '{print $2}')
  t_clients=$(transmission-remote -n $t_usr:$t_pass -st)
  echo -e "$t_clients"
  ;;
"transmission_active")
  t_usr=$(cat /etc/config/transmission |grep rpc_username |awk -F"'" '{print $2}')
  t_pass=$(cat /etc/config/transmission |grep rpc_password |awk -F"'" '{print $2}')
  t_down=$(transmission-remote -n $t_usr:$t_pass -l |grep -E 'Up|Down|Downloading|Seeding' |sed 's/%//g')
  echo -e "$t_down"
  ;;
"restart_bot")
  echo -e "Pulpstone Telegram BOT Restart"
  killall pulpstone_telegram_bot && /etc/init.d/pulpstone_telegram_bot start
  ;;
"bot_go_private")
  cd /root/pulpstone_bot
  sed -i -e 's/#*my_chat_id/my_chat_id/' variables
  echo -e "Pulpstone Telegram BOT go Private!"
  ;;
"bot_go_public")
  cd /root/pulpstone_bot
  sed -i -e 's/my_chat_id/#my_chat_id/' variables
  echo -e "Pulpstone Telegram BOT go Public!"
  ;;
"bot_status")
  status=$(cat /root/pulpstone_bot/variables |grep chat_id |awk -F "=" '{print $1}')
  if [ "$status" == "my_chat_id" ];then
	echo -e "Pulpstone Telegram BOT Private Mode"
  else
    echo -e "Pulpstone Telegram BOT Public Mode"
  fi	
  ;;
"bot")
  echo -e "Available /bot: \n\n/bot_status \n/bot_go_public \n/bot_go_private \n\nBack: /list"
  ;;
"script_version")
  rm -f /tmp/script_version &> /dev/null
  sv_current=$(cat /root/pulpstone_bot/functions/script_version.sh)
  sv_online=$(wget -q --no-check-certificate https://goo.gl/Cgro2F -O /tmp/script_version)
  sv_online=$(cat /tmp/script_version)
  echo -e "Script Version Pulpstone BOT \nCurrent:\n$sv_current \n\nServer\n$sv_online \n\nUpdate: /update_script \nBack: /list"
  ;;
"about")
  echo -e "Pulpstone Telegram Bot \n\nLede_Openwrt_Telegram_Bot by filirnd \nAll Pulpstone Script by fuadsalim \nPulpstone OpenWrt/LEDE \nWebsite: http://pulpstone.pw \nFacebook: fb.com/pulpstone \nYouTube: https://goo.gl/ZGhP6t \nDon't Forget to Brush your Teeth at least Twice a Day :)"
  ;;
"list")
  echo -e "Available: \n\n/reboot \n/shutdown \n/restart_bot \n/restart_xderm \n/connected_clients \n/memory \n/temperature \n/network_traffic \n/my_ip \n/3g_info \n/transmission \n/mpd \n/gpio \n/bot \n/script_version \n/about \n\nPulpstone OpenWrt/LEDE"
  ;;

  *)
    echo -e "List of Commands \n/list"
;;
esac


