#!/bin/bash
# Auto Reboot VPS

tanggal=$(date +"%m-%d-%Y")
waktu=$(date +"%T")
echo "Server telah berhasil reboot pada tanggal $tanggal pukul $waktu." >> /root/log-reboot.txt
sudo reboot
