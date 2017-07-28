#!/bin/bash

http_host="$1"
http_port="$2"
https_host="$3"
https_port="$4"
ftp_host="$5"
ftp_port="$6"


function remove_prev(){
	sudo sed -i '/http/d' /etc/environment
	sudo sed -i '/HTTP/d' /etc/environment
	sudo sed -i '/ftp/d' /etc/environment
	sudo sed -i '/FTP/d' /etc/environment
}

function setEnv(){
	printf "http_proxy="http://$1:$2"\nhttps_proxy="https://$3:$4"\nftp_proxy="ftp://$5:$6"\nHTTP_PROXY="http://$1:$2"\nHTTPS_PROXY="https://$3:$4"\nFTP_PROXY="ftp://$5:$6"\n" |	sudo tee -a /etc/environment > /dev/null
}

if grep -q "proxy" /etc/environment || grep -q "PROXY" /etc/environment 
then
    remove_prev
    setEnv "$1" "$2" "$3" "$4" "$5" "$6"
else
    setEnv "$1" "$2" "$3" "$4" "$5" "$6" 
fi
