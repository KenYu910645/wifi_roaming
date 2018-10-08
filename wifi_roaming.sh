#! /bin/bash

legel_ssid=(ASUS_AC5300_5G ASUS_AC5300 ASUS_AC5300_5G-2 luckys_net)
SIGNAL_THESHOLD=10
declare -A password
password=( ["ASUS_AC5300"]="@Advrobot" ["luckys_net"]="doctorso3" ["ASUS_AC5300_5G"]="@Advrobot" )


while : 
do 

nmcli -f in-use,ssid,bssid,signal dev wifi | grep -n \* -B999 | awk '{print $1 " " $2 " " $3 "  " $4}' > temp.txt


current_wifi=$(  cat temp.txt | grep \* | tail -n1 )
current_SIGNAL=$(echo $current_wifi | awk '{print $4}') 

exec < 'temp.txt'

while read line
do 
     ssid=$(  echo $line | awk '{print $2}')
     bssid=$( echo $line | awk '{print $3}')
     signal=$(echo $line | awk '{print $4}')
     
     is_valid_ssid=false
     # SSID check
     for name in ${legel_ssid[@]}; do
         if [ "$ssid" == "$name" ]; then
             is_valid_ssid=true
         fi
     done
     
     if [ "$is_valid_ssid" == false ]; then
         continue
     fi
     
     # Signal check
     if [ "$((signal - current_SIGNAL))" -gt "$SIGNAL_THESHOLD" ]; then
         echo Switch to AP : 
         echo $line
         # Switch AP
         nmcli d wifi connect $bssid password "${password[$ssid]}"
         break
     fi
done 

echo "current_wifi : ${current_wifi}" 

sleep 2
done 
