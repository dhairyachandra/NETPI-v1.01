# !/bin/bash
echo -e "\e[1;41;97mNETPI Script v1.01\e[0m"
echo "Creators"
echo "Twitter and Github- Ctrl + Click"
echo -e '\e]8;;https://www.github.com/navjots7\aNavjot- Github\e]8;;\a'
echo -e '\e]8;;https://www.github.com/dhairyachandra\aDhairya- Github\e]8;;\a'
echo -e '\e]8;;https://www.twitter.com/navjot7s\aNavjot- Twitter\e]8;;\a'
echo -e '\e]8;;https://www.twitter.com/dhairyachandra\aDhairya- Twitter\e]8;;\a'
sleep 4s
echo $(reset)
user1="	Link detected: yes"
echo "Checking all the Network Interfaces..."
sleep 2s
array_test=()
for iface in $(ifconfig | cut -d ' ' -f1| tr ':' '\n' | awk NF)
do
        printf "$iface\n"
        array_test+=("$iface")
done
echo "Please enter the network interface"
read var
echo "Checking the state of the user interface......."
sleep 1s
user=$(ethtool $var | grep -i "Link detected: yes")

if [[ $user != $user1 ]]
then
   echo "$var is down"
	echo "Bringing $var up"
	echo $(ifconfig $var up)
	echo "Waiting for 5 Seconds to bring the device up"
	sleep 5s
	user3=$(ethtool $var | grep -i "Link detected: yes")
		if [[ $user3 != $user1 ]]
		then
		echo "Not able to bring $var up"
		echo "Quiting the Application"
		exit	
		else
		echo "$var is now up"
		fi	
else
   echo "$var is up"
fi
echo $(reset)
echo -e "\033[31;7mChoosing an invalid input will directly take you to MAIN MENU\e[0m"
PS3=$'\e[01;33mPlease Enter your choice \e[0m'
options=("IP Address" "MAC Address" "Turn off the interface" "Gateway IP" "whois" "hostname" "Clear" "Quit")
select opt in "${options[@]}" 
do
	case $opt in
		"IP Address")
		echo $(ifconfig $var | awk '/inet/{print $2}')
		;;
		"MAC Address")
		echo $(ip link show $var | grep link/ether | awk '{print $2}')
		;;
		"Turn off the interface")
		echo "Are you sure to turn off $var? (y/n/e=exit)"
		read user_in
			case $user_in in
			"y")
			echo "Bringing $var Down"
			echo $(ifconfig $var down)	
			echo "Quitting the Application as it needs an interface to further work on"
			echo "bye bye"
			echo $(printf "\03cc")
			exit;;
			"n")
			echo "You chose no"
			echo "Going to main menu"
			echo $(printf "\03cc")
			;;
			"e")
			echo "Going to main menu"
			echo $(printf "\03cc")
			;;
			*)
			echo "Invalid Input $user_in";;
			esac
;;
		"Gateway IP")
		echo $(route -n | grep 'UG[ \t]' | awk '{print $2}')		
		;;	
		"whois")
		echo "Enter the Wesite name follwed by .com, .net, etc"	
		read whoentry
		whois $whoentry > output.txt
		echo "The output is saved in the output.txt file. Location will be same as the location of this file."		
		;;
		"hostname")
		echo $(hostname)
		echo $(printf "\03cc")
		;;		
		"Clear")
		echo $(printf "\033c")
		;;
		"Quit")
		echo "You chose option $opt"
		echo "bye bye"
		echo $(reset)
		break
		;;
		*) echo "Invalid response $REPLY";;
	esac
done
