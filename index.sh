#!/bin/bash 

# This is a script to change proxy in Linux.


# Made by "Hritik Gupta"
# For ProxyBud "https://github.com/hritikgupta/ProxyBud"


finalGreet(){
	whiptail --title "** SUCCESS **" --msgbox "Thanks for using PROXYBUD.\n\nStar it, if you liked it : https://github.com/hritikgupta/ProxyBud" 10 78
}

function valid_ip(){
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi

	if [ "$stat" -ne 0 ]; then
		whiptail --textbox /dev/stdin 12 60 <<<"You have entered an invalid IP. Try again!\n\nExiting ..."
		status=1
		exit
	fi
}

function valid_port(){
	if [ -z "$1" ]
	then
		whiptail --textbox /dev/stdin 12 60 <<<"Port number not entered. Try again!\n\nExiting ..."
		status=1
		exit
	fi
}

whiptail --title "** PROXYBUD **" --yesno "Hello, $USER\nLet's change your system proxy. Modifications will be made to :

    bashrc    apt.conf    environment-variable    network proxy    git

Start the program?" 12 78
 
exitstatus=$?
if [ $exitstatus = 0 ]; then
    status="0"
    while [ "$status" -eq 0 ]  
    do
        CHOICE=$(
		whiptail --title "** PROXYBUD **" --menu "\n\nMake your choice : \n" 16 78 6 \
			"1)" "Set Proxy"   \
			"2)" "Unset Proxy"  3>&2 2>&1 1>&3	
		)
         
        case $CHOICE in
        		"1)") 
                	prox=$(whiptail --inputbox "Enter Proxy Host : " 8 78 --title "Input" 3>&1 1>&2 2>&3)
					valid_ip $prox

                	port=$(whiptail --inputbox "Enter Proxy Port : " 8 78 --title "Input" 3>&1 1>&2 2>&3)
					valid_port $port

                	whiptail --title "Prompt" --yesno "Use the same proxy for https/ftp?" 8 78 
					exitstatus=$?
					if [ $exitstatus = 0 ]; then
						if [ "$(id -nu)" != "root" ]; then
						    sudo -k
						    pass=$(whiptail --title " Sudo access required " --passwordbox "Please authenticate to begin: \n\n[sudo] Password for user $USER:" 12 50 3>&2 2>&1 1>&3-)
						fi
						finalGreet
						exec sudo -S -p '' "bash" "set.sh" <<< "$pass" "$prox" "$port" "$prox" "$port" "$prox" "$port" 
					else
					    shost=$(whiptail --inputbox "Enter Proxy Host for HTTPS: " 8 78 --title "Input" 3>&1 1>&2 2>&3)
						valid_ip $shost

                		sport=$(whiptail --inputbox "Enter Proxy Port for HTTPS: " 8 78 --title "Input" 3>&1 1>&2 2>&3)
						valid_port $sport

                		fhost=$(whiptail --inputbox "Enter Proxy Host for FTP: " 8 78 --title "Input" 3>&1 1>&2 2>&3)
						valid_ip $fhost

                		fport=$(whiptail --inputbox "Enter Proxy Port for FTP: " 8 78 --title "Input" 3>&1 1>&2 2>&3)
						valid_port $fport

                		if [ "$(id -nu)" != "root" ]; then
						    sudo -k
						    pass=$(whiptail --title " Sudo access required " --passwordbox "Please authenticate to begin: \n\n[sudo] Password for user $USER:" 12 50 3>&2 2>&1 1>&3-)
						fi
						finalGreet
						exec sudo -S -p '' "bash" "set.sh" <<< "$pass" "$prox" "$port" "$shost" "$sport" "$fhost" "$fport"
					fi
            ;;
            	"2)")
                	whiptail --title "Testing" --msgbox "You have chosen to unset proxy!" 8 78
                	if [ "$(id -nu)" != "root" ]; then
						    sudo -k
						    pass=$(whiptail --title " Sudo access required " --passwordbox "Please authenticate to begin: \n\n[sudo] Password for user $USER:" 12 50 3>&2 2>&1 1>&3-)
						fi
						finalGreet
						exec sudo -S -p '' "bash" "unset.sh" <<< "$pass" 
            ;;
            *) whiptail --title "Testing" --msgbox "You cancelled or have finished." 8 78
                status=1
                exit
            ;;
        esac
        exitstatus1=$status1
    done
else
    whiptail --title "Testing" --msgbox "You chose not to start." 8 78
    exit
fi