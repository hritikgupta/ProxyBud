#!bin/bash 

# This is a script to change proxy in Linux


# Made by "Hritik Gupta"
# For ProxyBud "https://github.com/hritikgupta/ProxyBud"

FILE="\desktop\rou.txt"
RED='\033[0;31m'
GREEN='\033[0;32m'
LGREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
LBLUE='\033[1;34m'
DGRAY='\033[1;30m'
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
echo "\n\nHello, "$USER"\nThis script will change your system proxy. \nModifications will be made to :
${DGRAY}bashrc    apt.conf    environment-variable    network proxy    git\n${NC}"

# inputs choice from the user
echo "What'd you like to do?\n ${BLUE}| 1 |${NC} ${LBLUE}Set Proxy${NC}\n ${BLUE}| 2 |${NC} ${LBLUE}Unset Proxy${NC}\nInput : \c"
read choice


#************************************************************begins

# reads host and port from user
if [ $choice = 1 ]; then
	echo "${RED}Proxy Host and press [Enter]: ${NC}\c"
	read prox
	echo "${RED}Proxy Port and press [Enter]: ${NC}\c"
	read port		

	echo "${YELLOW}Use the same proxy for https and ftp?(y/n) ${NC}\c"
	read char

	if [ $char = 'n' ];then
		echo "${RED}Proxy Host for HTTPS : ${NC}\c"
		read shost
		echo "${RED}Proxy Port for HTTPS : ${NC}\c"
		read sport
		echo "${RED}Proxy Host for FTP : ${NC}\c"
		read fhost
		echo "${RED}Proxy Port for FTP : ${NC}\c"
		read fport
		
	fi


	# gets the default shell of the system
	S="$SHELL"

	# used for comparing shells being used
	# currently works for bash and fish
	S1="/bin/bash"
	S2="/usr/bin/fish"

	if [ $S = $S1 ]; then
		if [ $char = 'y' ];then
			bash set.sh "$prox" "$port" "$prox" "$port" "$prox" "$port" 
		elif [ $char = 'n' ];then
			bash set.sh "$prox" "$port" "$shost" "$sport" "$fhost" "$fport"
		
	fi

	elif [ $choice = 2 ]; then
		echo "You've chosen to unset!\n"
		bash unset.sh 
			 	
 	else
 		echo '\nWrong choice! Try again.\n'

fi

echo "Done! Thanks for using ${GREEN}ProxyBud${NC}."
echo "${YELLOW}★${NC} Star it, if you like it :  ${LBLUE}\033[4mhttps://github.com/hritikgupta/ProxyBud\033[0m${NC}\n"