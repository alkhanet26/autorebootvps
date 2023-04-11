#!/bin/bash


{
echo -e "Downloading Binaries Files"
sleep 2
wget --no-check-certificate "https://raw.githubusercontent.com/alkhanet26/autorebootvps/main/auto-reboot.sh" -O /root/auto-reboot.sh && chmod +x /root/auto-reboot.sh
clear
echo -e "setting Auto Reboot at 00.00"
sleep 3
echo "0 0 * * * root /root/auto-reboot.sh" > /etc/cron.d/auto-reboot
clear
echo -e "Auto Reboot VPS installed"
sleep 3
}
