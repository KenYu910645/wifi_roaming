#! /bin/bash

# current_wifi=$(nmcli -f in-use,ssid,bssid,signal,bars dev wifi | grep  \* | tail -n1) # | awk '{ print $2 }'
nmcli -f in-use,ssid,bssid,signal dev wifi | grep -n \* -B999 | awk '{print $1 " " $2 " " $3 "  " $4}' > temp.txt


current_SSID=$(  cat temp.txt | grep \* | tail -n1 | awk '{print $2}') 
current_BSSID=$( cat temp.txt | grep \* | tail -n1 | awk '{print $3}') 
current_SIGNAL=$(cat temp.txt | grep \* | tail -n1 | awk '{print $4}') 




echo "current_wifi : ${current_wifi}" 
echo "current_SSID : ${current_SSID}" 
echo "current_BSSID : ${current_BSSID}" 
echo "current_SIGNAL : ${current_SIGNAL}" 

