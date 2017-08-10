#!bin/bash 

# This is a script to change proxy in Linux


# Made by "Hritik Gupta"
# For ProxyBud "https://github.com/hritikgupta/ProxyBud"

# configuration files modified: bashrc, apt, env/environment, gsettings, git


http_host="$1"
http_port="$2"
https_host="$3"
https_port="$4"
ftp_host="$5"
ftp_port="$6"


# set proxy in aptitude
bash apt.sh "$http_host" "$http_port" "$https_host" "$https_port" "$ftp_host" "$ftp_port"


# proxy for etc/environment
printf "http_proxy="http://$1:$2"\nhttps_proxy="https://$3:$4"\nftp_proxy="ftp://$5:$6"\nHTTP_PROXY="http://$1:$2"\nHTTPS_PROXY="https://$3:$4"\nFTP_PROXY="ftp://$5:$6"\n" |	sudo tee -a /etc/environment > /dev/null

# proxy for gnome settings
gsettings set org.gnome.system.proxy mode manual
gsettings set org.gnome.system.proxy.http host "$1"
gsettings set org.gnome.system.proxy.http port "$2"
gsettings set org.gnome.system.proxy.https host "$3"
gsettings set org.gnome.system.proxy.https port "$4"
gsettings set org.gnome.system.proxy.ftp host "$5"
gsettings set org.gnome.system.proxy.ftp port "$6"
gsettings set org.gnome.system.proxy.socks host "$1"
gsettings set org.gnome.system.proxy.socks port "$2"

# proxy for bashrc
export http_proxy=http://"$1":"$2"/
export https_proxy=http://"$3":"$4"/
export ftp_proxy=http://"$5":"$6"/

forGit(){
	git config --global http.proxy "http://$https_host":"$http_port"
	git config --global https.proxy "https://$https_host":"$https_port"
}

# set proxy for git
# checks if git is installed
git --version 2>&1 >/dev/null
git_avail=$?
# checks if git is installed and returns 0 if installed
if [ $git_avail -eq 0 ]; then 
	forGit
else
	wget -q --spider http://google.com
	# checks if system is online
	if [ $? -eq 0 ]; then
	    sudo apt-get install git &> /dev/null
	    forGit
		else
	    	echo 'Offline' > /dev/null
	fi
fi


