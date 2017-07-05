#!bin/bash

# for apt conf 
sudo sed -i '/Acquire::http/d' /etc/apt/apt.conf
sudo sed -i '/Acquire::ftp/d' /etc/apt/apt.conf
	
# for env/environment
sudo sed -i '/PATH=http/d' /etc/environment
sudo sed -i '/PATH=ftp/d' /etc/environment

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
# cheks if git is installed and returns 0 if installed
if [ $git_avail -eq 0 ]; then 
	forUnGit
	else
		echo 'Do Nothing' >> /dev/null
fi

