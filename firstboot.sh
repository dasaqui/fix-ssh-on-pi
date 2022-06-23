#!/bin/bash
sleep 2m
macadd=$( ip -brief add | awk '/UP/ {print $1}' | sort | head -1 )
if [ ! -z "${macadd}" ]
then
  macadd=$( sed 's/://g' /sys/class/net/${macadd}/address )
  sed "s/raspberrypi/${macadd}/g" -i /etc/hostname /etc/hosts
fi

# disable auto-login on tty1
login_file="/etc/systemd/system/getty@tty1.service.d/autologin.conf"
mv "${login_file}" "${login_file}.disabled"

/sbin/shutdown -r 5 "reboot in Five minutes"
