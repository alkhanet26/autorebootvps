#!/bin/bash


{
sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1
clear
echo -e "Install X-UI English"
#bash <(curl -Ls https://raw.githubusercontent.com/MrCenTury/xXx-UI/master/install.sh)
sudo su -c "$(command -v apt||echo dnf) -y install wget;bash <(wget -qO- raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/x-ui-pro.sh) -panel 1 -xuiver last -cdn off -secure no -country xx"
clear
echo -e "Installasi X-ui selesai"
echo -e "Install certbot"
apt install certbot -y
clear
echo -e "Installasi CerBOT Selesai"
echo -e "Memulai Installasi WARP Cloudflare"
wget --no-check-certificate "https://raw.githubusercontent.com/alkhanet26/vpsfree/main/warp.sh" -O /usr/bin/warp && chmod +x /usr/bin/warp
clear
echo -e "Installasi WARP selesai"
echo -e "Memulai installasi Auto Reboot VPS"
echo -e "Downloading Binaries Files"
sleep 2
wget --no-check-certificate "https://raw.githubusercontent.com/alkhanet26/vpsfree/main/auto-reboot.sh" -O /root/auto-reboot.sh && chmod +x /root/auto-reboot.sh
clear
echo -e "setting Auto Reboot at 00.00"
sleep 3
echo "0 0 * * * root bash /root/auto-reboot.sh" > /etc/cron.d/auto-reboot
echo -e "Setting Permission Auto Reboot"
chmod +x /etc/cron.d/auto-reboot && chmod +x /root/auto-reboot.sh
clear
echo -e "Auto Reboot VPS installed"
echo -e "Memulai Installasi Speedtest"
wget --no-check-certificate "https://raw.githubusercontent.com/alkhanet26/vpsfree/main/speedtest" -O /usr/bin/speedtest && chmod +x /usr/bin/speedtest
clear
echo -e "Installasi Speedtest Selesai"
sleep 3
wget --no-check-certificate "https://raw.githubusercontent.com/alkhanet26/vpsfree/main/rebootvps" -O /root/rebootvps && chmod +x /root/rebootvps
wget --no-check-certificate "https://raw.githubusercontent.com/alkhanet26/vpsfree/main/rewarp" -O /root/rewarp && chmod +x /root/rewarp
}
