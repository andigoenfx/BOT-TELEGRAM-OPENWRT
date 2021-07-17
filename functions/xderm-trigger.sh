#!/bin/sh
# Copyright (C) 2021
# Author: AndiGoen
# Date : 14 Juli 2021

dir=/www/xderm/
xderm=xderm-mini

    cd $dir
    echo "Xderm is restarting"
    ./$xderm stop
	sleep 2
    ./$xderm start
	sleep 2
    myip=$(curl ipinfo.io/?format=jsonp&callback/plain 2> /dev/null)
    echo -e "You New IP : \n$myip"
