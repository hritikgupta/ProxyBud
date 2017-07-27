#!/bin/bash

http_host="$1"
http_port="$2"
https_host="$3"
https_port="$4"
ftp_host="$5"
ftp_port="$6"


if [ ! -e "/etc/apt/apt.conf" ]; then
		touch "/etc/apt/apt.conf"
fi

printf "\nAcquire::http::proxy  \""http://"$1":"$2""\";" |sudo tee -a /etc/apt/apt.conf > /dev/null
printf "\nAcquire::https::proxy  \""https://"$3":"$4""\";" |sudo tee -a /etc/apt/apt.conf > /dev/null
printf "\nAcquire::ftp::proxy  \""ftp://"$5":"$6""\";" |sudo tee -a /etc/apt/apt.conf > /dev/null 
