#!bin/bash 

#This is a script to change proxy in Linux

FILE="\desktop\rou.txt"
RED='\033[0;31m'
GREEN='\033[0;32m'
LGREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
LBLUE='\033[1;34m'
NC='\033[0m' # No Color

clear
echo "\n\t\c"
for i in `seq 0 27`;do
        echo "${LGREEN}*${NC}\c"
    done 
echo "\t\n${GREEN}\t PROXYBUD - Sets your proxy${NC}\t";
echo "\t\c"
for i in `seq 0 27`;do
        echo "${LGREEN}*${NC}\c"
    done 

# takes input from user
user="$USER"
echo "\n\nHello, "$USER"\nThis script will change your system proxy.\n\n"

echo "What'd you like to do?\n ${BLUE}| 1 |${NC} ${LBLUE}Set Proxy${NC}\n ${BLUE}| 2 |${NC} ${LBLUE}Unset Proxy${NC}\nInput : \c"
read choice


#************************************************************

# reads host and port from user
if [ $choice = 1 ]; then
	echo "${RED}Proxy Host and press [Enter]: ${NC}\c"
	read prox
	echo "${RED}Proxy Port and press [Enter]: ${NC}\c"
	read port		


	# gets the default shell of the system
	S="$SHELL"

	# used for comparing shells being used
	# currently works for bash and fish
	S1="/bin/bash"
	S2="/usr/bin/fish"

	if [ $S = $S1 ]; then
		bash set.sh "$prox" "$port" 

		else if [ $S = $S2 ];then

			# do something for fish 
			# doesn't work right now
			set http_proxy "http://"$prox":"$port"" 
			set https_proxy "https://"$prox":"$port""
			set ftp_proxy="http://"$prox":"$port"/" 
			# writes proxy to the apt.conf file for terminal 
			bash set.sh "$prox" "$port"
		fi
	fi

	elif [ $choice = 2 ]; then
		echo "You've chosen to unset!\n"
		bash unset.sh 
			 	
 	else
 		echo '\nWrong choice! Try again.\n'

fi

echo ""
echo "${YELLOW}★${NC} Star it, if you like it : \n"