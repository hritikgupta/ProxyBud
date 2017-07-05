#!bin/bash

host="$1"
port="$2"

# set proxy in aptitude
for proto in http https ftp; do
		    printf 'Acquire::%s::proxy "%s://%s:%u";\n' "$proto" "$proto" "$host" "$port"
		done |
		sudo tee -a /etc/apt/apt.conf > /dev/null


# proxy for etc/environment
printf "PATH="http_proxy=http://$host:$port/"\nPATH="https_proxy=https://$host:$port/"\nPATH="ftp_proxy=ftp://$host:$port/"\n" |
		sudo tee -a /etc/environment > /dev/null

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

# set proxy for git
sudo apt-get install git &> /dev/null
git config --global http.proxy http://"$host":"$host"
git config --global https.proxy https://"$host":"$host"