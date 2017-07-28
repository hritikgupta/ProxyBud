#!/bin/bash

http_host="$1"
http_port="$2"
https_host="$3"
https_port="$4"
ftp_host="$5"
ftp_port="$6"


function remove_prev(){
	sudo sed -i '/Acquire::http/d' /etc/apt/apt.conf
	sudo sed -i '/Acquire::ftp/d' /etc/apt/apt.conf
}

if [ ! -e "/etc/apt/apt.conf" ]; then
		touch "/etc/apt/apt.conf"
fi

function setNow(){
	printf "Acquire::http::proxy \""http://"$1":"$2""\";" |sudo tee -a /etc/apt/apt.conf > /dev/null
	printf "\nAcquire::https::proxy \""https://"$3":"$4""\";" |sudo tee -a /etc/apt/apt.conf > /dev/null
	printf "\nAcquire::ftp::proxy \""ftp://"$5":"$6""\";" |sudo tee -a /etc/apt/apt.conf > /dev/null 
}

if grep -q "Acquire::" /etc/apt/apt.conf
then
    remove_prev
    setNow "$1" "$2" "$3" "$4" "$5" "$6"
else
    setNow "$1" "$2" "$3" "$4" "$5" "$6"
fi
