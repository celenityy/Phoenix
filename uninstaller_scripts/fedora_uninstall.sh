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
echo -e ""
echo_green_text "Is Firefox installed as a standard package, or as a Flatpak?";
echo_green_text "Your options are:";
echo_red_text "1. Standard package";
echo_green_text "2. Flatpak (System)";
read -p 'Please enter your selection: ' LOCATION
case ${LOCATION} in
	"standard" | "Standard" | "STANDARD" | 1)
        echo_green_text "Uninstalling phoenix..."
		sudo dnf remove phoenix || error_fn
		echo
		;;

	"flatpak" | "Flatpak" | "FLATPAK" | 2)
		echo_green_text "Uninstalling phoenix-flatpak..."
		sudo dnf remove phoenix-flatpak || error_fn
		echo
		;;
esac

read -p  $'\e[32mWould you also like to remove celenity''s COPR Repo? [Y/n] \e[0m' RESULT
echo

case ${RESULT} in

		"y" | "yes" | "YES" | "Y")
			echo_green_text "Removing celenity's COPR..."
			sudo dnf copr remove celenity/copr || error_fn
			echo

			echo_green_text "Updating DNF cache..."
			sudo dnf update --refresh || error_fn
			echo
			;;
		
		"n" | "no" | "N" | "NO")
			;;
esac

echo_green_text "Thanks for giving Phoenix a shot. Sorry to see you go :(. Please leave feedback on how we can improve! https://phoenix.celenity.dev/issues"
