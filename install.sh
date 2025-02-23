#!/usr/bin/env bash

## Downloaded files save in /tmp
cd /tmp

## Colours
blue='\e[1;34m'
brown='\e[0;33m'
coloroff='\e[0m' # Colour off
cyan='\e[1;36m'
gray='\e[1;30m'
green='\e[0;32m'
purple='\e[1;35m'
red='\e[1;31m'
yellow='\e[1;33m'

## Download and run install script
install_phoenix() {
	wget -nv $1
	echo
	echo
	sudo bash $2
}

## Scripts are here
URL="https://codeberg.org/celenity/Phoenix/raw/branch/pages/installer_scripts"

## Scripts file
SCRIPT=("arch_install_paru.sh"
		"arch_install_yay.sh"
		"debian_install.sh"
		"fedora_install.sh")

## Choose platform
echo -e "${purple}Welcome to the Phoenix installer!${coloroff}"
echo -e ""
echo -e "${yellow}To begin, please choose your platform (Its name or its number)${coloroff}"
echo -e "${yellow}Your options are:${coloroff}"
echo -e "${cyan}1. arch${coloroff}   - ${green}Arch Linux (AUR)${coloroff}"
echo -e "${red}2. debian${coloroff} - ${green}Debian GNU/Linux & Derivatives (openSUSE Build System)${coloroff}"
echo -e "${blue}3. fedora${coloroff} - ${green}Fedora Linux (COPR)${coloroff}"
echo -e "${brown}4. exit ${coloroff}  - ${green}Exit the Phoenix installer${coloroff}"

read -p 'Enter your selection: ' PLATFORM

case ${PLATFORM} in
	"arch" | "Arch" | "ARCH" | 1)
		echo -e ""
		echo -e "${yellow}Please choose your AUR helper (Its name or its number)${coloroff}"
		echo -e "${yellow}Your options are:${coloroff}"
		echo -e "${blue}1. paru${coloroff} - ${green}Paru${coloroff}"
		echo -e "${red}2. yay${coloroff}  - ${green}Yay (Yet Another Yogurt)${coloroff}"
		read -p 'Enter your selection: ' AUR_HELPER
		case ${AUR_HELPER} in
			"paru" | "Paru" | "PARU" | 1)
				TARGET_SCRIPT="${SCRIPT[0]}"
				;;

			"yay" | "Yay" | "YAY" | 2)
				TARGET_SCRIPT="${SCRIPT[1]}"
				;;

			*)
				echo -e "${red}Invalid option.${coloroff}"
				exit 1
				;;
		esac
		;;

	"debian" | "Debian" | "DEBIAN" | 2)
		TARGET_SCRIPT="${SCRIPT[2]}"
		;;

	"fedora" | "Fedora" | "FEDORA" | 3)
		TARGET_SCRIPT="${SCRIPT[3]}"
		;;

	"exit" | "Exit" | "EXIT" | 4)
		exit 0
		;;

	*)
		echo -e "${red}Invalid option.${coloroff}"
		exit 1
		;;
esac

## Download and run choosen platform script
install_phoenix "${URL}"/"${TARGET_SCRIPT}" "${TARGET_SCRIPT}"
