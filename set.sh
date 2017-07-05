#!bin/bash 

# This is a script to change proxy in Linux


# Made by "Hritik Gupta"
# For ProxyBud "https://github.com/hritikgupta/ProxyBud"

# host = proxy host 
# port = proxy port
# configuration files modified: bashrc, apt, env/environment, gsettings, git


host="$1"
port="$2"

# set proxy in aptitude
for proto in http https ftp; do
		    printf 'Acquire::%s::proxy "%s://%s:%u";\n' "$proto" "$proto" "$host" "$port"
		done |
		sudo tee -a /etc/apt/apt.conf > /dev/null


# proxy for etc/environment
printf "http_proxy="http://$host:$port"\nhttps_proxy="https://$host:$port"\nftp_proxy="ftp://$host:$port"\nHTTP_PROXY="http://$host:$port"\nHTTPS_PROXY="https://$host:$port"\nFTP_PROXY="ftp://$host:$port"\n" |	sudo tee -a /etc/environment > /dev/null

# proxy for gnome settings
gsettings set org.gnome.system.proxy mode manual
gsettings set org.gnome.system.proxy.http host "$host"
gsettings set org.gnome.system.proxy.http port "$port"
gsettings set org.gnome.system.proxy.https host "$host"
gsettings set org.gnome.system.proxy.https port "$port"
gsettings set org.gnome.system.proxy.ftp host "$host"
gsettings set org.gnome.system.proxy.ftp port "$port"
gsettings set org.gnome.system.proxy.socks host "$host"
gsettings set org.gnome.system.proxy.socks port "$port"

# proxy for bashrc
export http_proxy=http://"$host":"$port"/
export https_proxy=http://"$host":"$port"/
export ftp_proxy=http://"$host":"$port"/

forGit(){
	git config --global http.proxy "$host":"$port"
	git config --global https.proxy "$host":"$port"
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


