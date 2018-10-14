#! /bin/bash


while : 
do 
nmcli -f in-use,ssid,bssid,signal dev wifi | grep -n \* -B999 | awk '{print $1 " " $2 " " $3 "  " $4}' > temp.txt
current_wifi=$(  cat temp.txt | grep \* | tail -n1 )
current_SIGNAL=$(echo $current_wifi | awk '{print $4}') 

elevator_ping=$(ping -c1 192.168.64.11 | grep avg | awk '{print $4}' | cut -d "/" -f2)
robocall_ping=$(ping -c1 192.168.64.10 | grep avg | awk '{print $4}' | cut -d "/" -f2)

if [ $elevator_ping == "" ]; then
    elevator_ping="Unreachable"
fi

if [ $robocall_ping == "" ]; then
    robocall_ping="Unreachable"
fi


echo  "    SSID   BSSID             SIGNAL     elevator_ping       robotcall_ping"
echo -e ${current_wifi} "       "  "\033[1;33m${elevator_ping}\033[0m" "            " "\033[1;32m${robocall_ping}\033[0m"
sleep 2
done 
