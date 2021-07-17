#!/bin/sh
pulpstone_gpio=16-03-2018
gpio_A=$(grep gpio_A /root/pulpstone_bot/pulpstone_bot.conf |awk -F"=" '{print $2}')
gpio_B=$(grep gpio_B /root/pulpstone_bot/pulpstone_bot.conf |awk -F"=" '{print $2}')
gpio_C=$(grep gpio_C /root/pulpstone_bot/pulpstone_bot.conf |awk -F"=" '{print $2}')
gpio_D=$(grep gpio_D /root/pulpstone_bot/pulpstone_bot.conf |awk -F"=" '{print $2}')
nama_gpioA=$(grep nama_gpioA /root/pulpstone_bot/pulpstone_bot.conf |awk -F"=" '{print $2}')
nama_gpioB=$(grep nama_gpioB /root/pulpstone_bot/pulpstone_bot.conf |awk -F"=" '{print $2}')
nama_gpioC=$(grep nama_gpioC /root/pulpstone_bot/pulpstone_bot.conf |awk -F"=" '{print $2}')
nama_gpioD=$(grep nama_gpioD /root/pulpstone_bot/pulpstone_bot.conf |awk -F"=" '{print $2}')
case $1 in
"gpio_A_ON")
  echo "1" > /sys/class/gpio/gpio$gpio_A/value
  echo -e "$nama_gpioA ON"
  echo -e "$nama_gpioA ON" > /root/pulpstone_bot/functions/pulpstone_gpio_A.txt
  ;;
"gpio_A_OFF")
  echo "0" > /sys/class/gpio/gpio$gpio_A/value      
  echo -e "$nama_gpioA OFF"
  echo -e "$nama_gpioA OFF" > /root/pulpstone_bot/functions/pulpstone_gpio_A.txt
  ;;
"gpio_B_ON")
  echo "1" > /sys/class/gpio/gpio$gpio_B/value
  echo -e "$nama_gpioB ON"
  echo -e "$nama_gpioB ON" > /root/pulpstone_bot/functions/pulpstone_gpio_B.txt
  ;;
"gpio_B_OFF")
  echo "0" > /sys/class/gpio/gpio$gpio_B/value      
  echo -e "$nama_gpioB OFF"
  echo -e "$nama_gpioB OFF" > /root/pulpstone_bot/functions/pulpstone_gpio_B.txt
  ;;
"gpio_C_ON")
  echo "1" > /sys/class/gpio/gpio$gpio_C/value
  echo -e "$nama_gpioC ON"
  echo -e "$nama_gpioC ON" > /root/pulpstone_bot/functions/pulpstone_gpio_C.txt
  ;;
"gpio_C_OFF")
  echo "0" > /sys/class/gpio/gpio$gpio_C/value      
  echo -e "$nama_gpioC OFF"
  echo -e "$nama_gpioC OFF" > /root/pulpstone_bot/functions/pulpstone_gpio_C.txt
  ;;
"gpio_D_ON")
  echo "1" > /sys/class/gpio/gpio$gpio_D/value
  echo -e "$nama_gpioD ON"
  echo -e "$nama_gpioD ON" > /root/pulpstone_bot/functions/pulpstone_gpio_D.txt
  ;;
"gpio_D_OFF")
  echo "0" > /sys/class/gpio/gpio$gpio_D/value      
  echo -e "$nama_gpioD OFF"
  echo -e "$nama_gpioD OFF" > /root/pulpstone_bot/functions/pulpstone_gpio_D.txt
  ;;
"gpio_status")
  stA=$(cat /root/pulpstone_bot/functions/pulpstone_gpio_A.txt)
  stB=$(cat /root/pulpstone_bot/functions/pulpstone_gpio_B.txt)
  stC=$(cat /root/pulpstone_bot/functions/pulpstone_gpio_C.txt)
  stD=$(cat /root/pulpstone_bot/functions/pulpstone_gpio_D.txt)
  echo -e "$stA \n$stB \n$stC \n$stD"
  ;;
"gpio")
  use_gpio=$(grep use_gpio /root/pulpstone_bot/pulpstone_bot.conf |awk -F"=" '{print $2}')
  if [ "$use_gpio" == "yes" ];then
    echo -e "Available /gpio: \n\n$nama_gpioA \n/gpio_A_ON \n/gpio_A_OFF \n$nama_gpioB \n/gpio_B_ON \n/gpio_B_OFF \n$nama_gpioC \n/gpio_C_ON \n/gpio_C_OFF \n$nama_gpioD \n/gpio_D_ON \n/gpio_D_OFF \nStatus \n/gpio_status \n\nBack: /list"
  else
    echo -e "Not use GPIO!"
  fi
  ;;

  *)
    echo -e "List of GPIO Commands \n/gpio"
;;
esac
