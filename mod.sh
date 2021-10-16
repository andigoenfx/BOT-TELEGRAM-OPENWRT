#!/bin/bash

opkg update
wget --no-check-certificate "https://raw.githubusercontent.com/andigoenfx/BOT-TELEGRAM-OPENWRT/main/functions/pulpstone_general.sh" -O /root/pulpstone_bot/functions/pulpstone_general.sh
wget --no-check-certificate "https://raw.githubusercontent.com/andigoenfx/BOT-TELEGRAM-OPENWRT/main/functions/xderm-trigger.sh" -O /root/pulpstone_bot/functions/xderm-trigger.sh
wget --no-check-certificate "https://raw.githubusercontent.com/andigoenfx/BOT-TELEGRAM-OPENWRT/main/pulpstone_telegram_bot" -O /root/pulpstone_bot/pulpstone_telegram_bot
chmod +x /root/pulpstone_bot/functions/xderm-trigger.sh
chmod +x /root/pulpstone_bot/functions/pulpstone_general.sh
chmod +x /root/pulpstone_bot/pulpstone_telegram_bot
sleep 2
echo "install selesai"
echo "router akan reboot terlebih dahulu"
reboot
