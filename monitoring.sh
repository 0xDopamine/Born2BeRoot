#!/bin/bash

ARCH=$(uname -a)
CPU=$(lscpu | grep "CPU(s):" | awk 'NR==1 {print $2}')
vCPU=$(cat /proc/cpuinfo | grep processor | wc -l)
MEM=$(free -m | awk 'NR==2 {print($3 "/" $7 "MB " " " "("$3/$2*100.0"%)")}')
DSKmb=$(df -Bm | awk 'NR==4 {print substr($3, 1, 4)}')
DSKgb=$(df -Bg | awk 'NR==4 {print substr($4, 1, 1)"Gb ""("$5")"}')
CPULD=$(mpstat | awk 'NR==4 {print($4"%")}')
BOOT=$(who -b | awk '{print($3" "$4)}')
TCP=$(ss -s | awk 'NR==2 {print($2 " ESTABLISHED")}')
LOG=$(who | wc -l)
IP=$(hostname -I)
MAC=$(ip link show | grep "ether" | awk '{print("("$2")")}')
SUDO=$(grep -a "COMMAND=" /var/log/auth.log | wc -l)
VAR=$(lsblk | grep lvm | wc -l)
LVM=$(if [ "$var" = 0 ]; then echo "no"; else echo "yes"; fi)

echo "#Architecture: $ARCH"
echo "#CPU Physical: $CPU"
echo "#vCPU: $vCPU"
echo "#Memomry Usage: $MEM"
echo "#Disk Usage: $DSKmb/$DSKgb"
echo "#CPU Load: $CPULD"
echo "#Last boot: $BOOT"
echo "#LVM use: $LVM"
echo "#Connexions TCP: $TCP"
echo "#Users log: $LOG"
echo "#Network: IP $IP $MAC"
echo "#sudo: $SUDO cmd"
