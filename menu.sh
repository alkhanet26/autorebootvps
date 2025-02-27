#!/bin/bash
MYIP=$(curl -sS ipv4.icanhazip.com)
#echo "Checking VPS"
#########################
IZIN=$(curl -sS https://raw.githubusercontent.com/alkhanet26/bacot/main/mangga | awk '{print $4}' | grep $MYIP)
if [ $MYIP = $IZIN ]; then
echo -e "\e[32mPermission Accepted...\e[0m"
else
echo -e "\e[31mPermission Denied!\e[0m";
echo -e "\e[31mDaftarkan IP VPS anda,, Hub Admin : ALKNET wa : 08815260626... Salam Ngopi,, #\e[0m"
exit 0
fi
#EXPIRED
expired=$(curl -sS https://raw.githubusercontent.com/alkhanet26/bacot/main/mangga | grep $MYIP | awk '{print $3}')
echo $expired > /root/expired.txt
today=$(date -d +1day +%Y-%m-%d)
while read expired
do
	exp=$(echo $expired | curl -sS https://raw.githubusercontent.com/alkhanet26/bacot/main/mangga | grep $MYIP | awk '{print $3}')
	if [[ $exp < $today ]]; then
		Exp2="\033[1;31mExpired\033[0m"
        else
        Exp2=$(curl -sS https://raw.githubusercontent.com/alkhanet26/bacot/main/mangga | grep $MYIP | awk '{print $3}')
	fi
done < /root/expired.txt
rm /root/expired.txt
Name=$(curl -sS https://raw.githubusercontent.com/alkhanet26/bacot/main/mangga | grep $MYIP | awk '{print $2}')
# Color Validation
DF='\e[39m'
Bold='\e[1m'
Blink='\e[5m'
yell='\e[33m'
red='\e[31m'
green='\e[32m'
blue='\e[34m'
PURPLE='\e[35m'
cyan='\e[36m'
Lred='\e[91m'
Lgreen='\e[92m'
Lyellow='\e[93m'
NC='\e[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
LIGHT='\033[0;37m'
# VPS Information
#Domain
domain=$(cat /etc/xray/domain)
#Status certificate
modifyTime=$(stat $HOME/.acme.sh/${domain}_ecc/${domain}.key | sed -n '7,6p' | awk '{print $2" "$3" "$4" "$5}')
modifyTime1=$(date +%s -d "${modifyTime}")
currentTime=$(date +%s)
stampDiff=$(expr ${currentTime} - ${modifyTime1})
days=$(expr ${stampDiff} / 86400)
remainingDays=$(expr 90 - ${days})
tlsStatus=${remainingDays}
if [[ ${remainingDays} -le 0 ]]; then
	tlsStatus="expired"
fi
# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"
# Download
#Download/Upload today
dtoday="$(vnstat -i eth0 | grep "today" | awk '{print $2" "substr ($3, 1, 1)}')"
utoday="$(vnstat -i eth0 | grep "today" | awk '{print $5" "substr ($6, 1, 1)}')"
ttoday="$(vnstat -i eth0 | grep "today" | awk '{print $8" "substr ($9, 1, 1)}')"
#Download/Upload yesterday
dyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $2" "substr ($3, 1, 1)}')"
uyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $5" "substr ($6, 1, 1)}')"
tyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $8" "substr ($9, 1, 1)}')"
#Download/Upload current month
dmon="$(vnstat -i eth0 -m | grep "`date +"%Y-%m"`" | awk '{print $2" "substr ($3, 1, 3)}')"
umon="$(vnstat -i eth0 -m | grep "`date +"%Y-%m"`" | awk '{print $5" "substr ($6, 1, 3)}')"
tmon="$(vnstat -i eth0 -m | grep "`date +"%Y-%m"`" | awk '{print $8" "substr ($9, 1, 3)}')"
# Getting CPU Information
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
cpu_usage+=" %"
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
#CITY=$(curl -s ipinfo.io/city )
#WKT=$(curl -s ipinfo.io/timezone )
DAY=$(date +%A)
DATE=$(date +%m/%d/%Y)
IPVPS=$MYIP
cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
tram=$( free -m | awk 'NR==2 {print $2}' )
uram=$( free -m | awk 'NR==2 {print $3}' )
fram=$( free -m | awk 'NR==2 {print $4}' )
# DISK Information
pdisk=$(df -h | grep "G" | cut -d'G' -f4 | cut -d/ -f1 | cut -d' ' -f3)
tdisk=$(df -h | grep "G" | cut -d'G' -f1 | cut -d' ' -f9)
udisk=$(df -h | grep "G" | cut -d'G' -f2 | cut -d' ' -f3)
# ACCOUNT INFORMATION
jssh="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
jvms="$(grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | wc -l)"
jtj="$(grep -E "^#! " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | wc -l)"
jvls="$(grep -E "^#& " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | wc -l)"
# // Xray Proxy
ss=$( systemctl status xray | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $ss == "running" ]]; then
    status_ss="${green}ON"
else
    status_ss="${red}OFF"
fi

# // NGINX
nginx=$( systemctl status nginx | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $nginx == "running" ]]; then
    status_nginx="${green}ON"
else
    status_nginx="${red}OFF"
fi

function ceka(){
        cat /etc/log-create-user.log

        read -n 1 -s -r -p "Press any key to back on menu"
        menu
}

clear 
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
figlet -f slant "ALK VPN" | lolcat
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " \E[33m               • INFORMATION •             \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[33m Operating System     \e[0m:  "`hostnamectl | grep "Operating System" | cut -d ' ' -f5-`	
echo -e "\e[33m CPU Usage            \e[0m:  $cpu_usage1 %"
echo -e "\e[33m Memory Usage         \e[0m:  $uram / $tram MB"
echo -e "\e[33m Disk Usage           \e[0m:  $udisk / $tdisk ($pdisk)"
echo -e "\e[33m System Uptime        \e[0m:  $uptime "
echo -e "\e[33m Isp Name             \e[0m:  $ISP"
echo -e "\e[33m Domain               \e[0m:  $domain"
echo -e "\e[33m Ip Vps               \e[0m:  $IPVPS"	
echo -e "\e[33m Usage This month     \e[0m:  $tmon"	
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " \E[33m             • SERVER STATUS •         \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "         \e[33mXRAY \E[0m: $status_ss    |    \e[33mNGINX \E[0m: $status_nginx"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "   \e[33mSSH \E[0m: $jssh | \e[33mVMESS \E[0m: $jvms | \e[33mTROJAN \E[0m: $jtj | \e[33mVLESS \E[0m: $jvls"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " \E[33m               • SUBSCRIPTION •        \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " \e[33mNama Klien	\E[0m: $Name"
echo -e " \e[33mExpired 	\E[0m: $Exp2"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " \E[33m                • PANEL MENU •                \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " [\e[36m•1\e[0m] SSH & OpenVPN Menu : [\e[36m•6\e[0m] Wireguard"
echo -e " [\e[36m•2\e[0m] Vmess Menu	 : [\e[36m•7\e[0m] SYSTEM Menu"
echo -e " [\e[36m•3\e[0m] Vless Menu	 : [\e[36m•8\e[0m] Status Service"
echo -e " [\e[36m•4\e[0m] Shadowsocks GRPC	 : [\e[36m•9\e[0m] Check Account"
echo -e " [\e[36m•5\e[0m] Trojan WSxGRPC	 : [\e[36m•10\e[0m] Clear RAM Cache"
#echo -e " [\e[36m•6\e[0m] L2TP"
echo -e   ""
echo -e   " Press x or [ Ctrl+C ] • To-Exit-Script"
echo -e   ""
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e   ""
read -p " Select menu :  "  opt
echo -e   ""
case $opt in
1) clear ; m-sshovpn ;;
2) clear ; m-vmess ;;
3) clear ; m-vless ;;
4) clear ; m-ssws ;;
5) clear ; m-trojan ;;
#6) clear ; l2tp ;;
6) clear ; wgr ;;
7) clear ; m-system ;;
8) clear ; running ;;
9) clear ; ceka ;;
10) clear ; clearcache ;;
x) exit ;;
*) echo "Anda salah tekan " ; sleep 1 ; menu ;;
esac
