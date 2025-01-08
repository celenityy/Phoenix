#! /usr/bin/env bash


## Functions
echo_red_text() {
	echo -e "\033[31m$1\033[0m"
}

echo_green_text() {
	echo -e "\033[32m$1\033[0m"
}

error_fn() {
	echo
	echo -e "\033[31mSomething went wrong! The script failed.\033[0m"
	echo -e "\033[31mPlease report this (with the output message) to https://phoenix.celenity.dev/issues\033[0m"
	echo
	exit 1
}


## Uninstall Phoenix
echo_green_text "Removing Phoenix or Phoenix-esr package..."

apt list -i phoenix 2>/dev/null | grep 'phoenix' &>/dev/null
if [[ $? -eq 0 ]]; then
	sudo apt remove phoenix
else
	sudo apt remove phoenix-esr
fi

echo -e "\033[32mWould you also like to remove celenity's OBS Repo? [Y/n] \033[0m"
read RESULT
echo

case ${RESULT} in

		"y" | "yes" | "YES" | "Y")
			echo_green_text "Removing celenity's OBS..."
			sudo rm /etc/apt/sources.list.d/home:celenity.list || error_fn
			echo

			echo_green_text "Remoing celenity's GPG key..."
			sudo rm /etc/apt/trusted.gpg.d/home_celenity.gpg || error_fn

			echo_green_text "Updating APT cache..."
			sudo apt update || error_fn
			echo
			;;
		
		"n" | "no" | "N" | "NO")
			;;
esac

echo_green_text "Thanks for giving Phoenix a shot. Sorry to see you go :(. Please leave feedback on how we can improve! https://phoenix.celenity.dev/issues"
