#! /bin/bash

current_wifi=$(nmcli -f in-use,ssid,bssid,signal,bars dev wifi | grep  \* | tail -n1) # | awk '{ print $2 }'

current_SSID=$(echo ${current_wifi:1} | awk '{print $1}')
current_BSSID=$(echo ${current_wifi:1} | awk '{print $2}')
current_SIGNAL=$(echo ${current_wifi:1} | awk '{print $3}')


echo "current_wifi : ${current_wifi}" 
echo "current_SSID : ${current_SSID}" 
echo "current_BSSID : ${current_BSSID}" 
echo "current_SIGNAL : ${current_SIGNAL}" 

