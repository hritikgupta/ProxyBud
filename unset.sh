#!bin/bash

# This is a script to change proxy in Linux


# Made by "Hritik Gupta"
# For ProxyBud "https://github.com/hritikgupta/ProxyBud"

# host = proxy host 
# port = proxy port
# configuration files modified: bashrc, apt, env/environment, gsettings, git


# for apt conf 
sudo sed -i '/Acquire::http/d' /etc/apt/apt.conf
sudo sed -i '/Acquire::ftp/d' /etc/apt/apt.conf
	
# for env/environment
sudo sed -i '/http/d' /etc/environment
sudo sed -i '/HTTP/d' /etc/environment
sudo sed -i '/ftp/d' /etc/environment
sudo sed -i '/FTP/d' /etc/environment

gsettings set org.gnome.system.proxy mode 'none'

# proxy for bashrc
export http_proxy=""
export https_proxy=""
export ftp_proxy=""

# unset for terminal
unset http_proxy
unset https_proxy
unset ftp_proxy

forUnGit(){
	git config --global --unset http.proxy
	git config --global --unset https.proxy
}

git --version 2>&1 >/dev/null 
git_avail=$?
# checks if git is installed and returns 0 if installed
if [ $git_avail -eq 0 ]; then 
	forUnGit
	else
		echo 'Do Nothing' >> /dev/null
fi

