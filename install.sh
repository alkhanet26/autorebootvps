#!/bin/bash


{
echo -e "Install X-UI English"
bash <(curl -Ls https://raw.githubusercontent.com/NidukaAkalanka/x-ui-english/master/install.sh)
clear
echo -e "Installasi X-ui selesai"
echo -e "Memulai Installasi WARP Cloudflare"
wget --no-check-certificate "https://raw.githubusercontent.com/alkhanet26/vpsfree/main/warp.sh" -O /sbin/warp && chmod +x /sbin/warp
clear
echo -e "Installasi WARP selesai"
echo -e "Memulai installasi Auto Reboot VPS"
echo -e "Downloading Binaries Files"
sleep 2
wget --no-check-certificate "https://raw.githubusercontent.com/alkhanet26/vpsfree/main/auto-reboot.sh" -O /root/auto-reboot.sh && chmod +x /root/auto-reboot.sh
clear
echo -e "setting Auto Reboot at 00.00"
sleep 3
echo "0 0 * * *  /root/auto-reboot.sh" > /etc/cron.d/auto-reboot
clear
echo -e "Auto Reboot VPS installed"
sleep 3
}
