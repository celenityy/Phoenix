#!/bin/bash

## Colours
blue='\e[1;34m';
brown='\e[0;33m';
coloroff='\e[0m'; # Colour off
cyan='\e[1;36m';
gray='\e[1;30m';
green='\e[0;32m';
purple='\e[0;35m';
red='\e[1;31m';

## Download and run script
install_phoenix() {
	wget -nv $1
	echo
	echo
	sudo bash $2
}

## Downloaded files save in /tmp
cd /tmp

## Scripts are here
URL="https://phoenix.celenity.dev/installer_scripts"

## Scripts file
SCRIPT=("arch_install_paru.sh"
		"arch_install_yay.sh"
		"debian_install.sh"
		"fedora_install.sh"
		"macos_install.sh")

echo -e "${purple}Welcome to the Phoenix installer!${coloroff}";
echo -e "";
echo -e "${brown}To begin, please choose your platform.${coloroff}";
echo -e "${brown}Your options are:${coloroff}";
echo -e "${cyan}arch${coloroff}   - ${green}Arch Linux (AUR)${coloroff}";
echo -e "${red}debian${coloroff} - ${green}Debian GNU/Linux (& Derivatives, such as Ubuntu)${coloroff}";
echo -e "${blue}fedora${coloroff} - ${green}Fedora Linux${coloroff}";
echo -e "${gray}macOS${coloroff}  - ${green}macOS${coloroff}";
read -p 'Enter your selection: ' DISTRO

case ${DISTRO} in

	"arch" | "Arch" | "ARCH")
		echo -e ""
		echo -e "${brown}Please choose your AUR helper.${coloroff}";
		echo -e "${brown}Your options are:${coloroff}";
		echo -e "${blue}paru${coloroff} - ${green}Pure${coloroff}";
		echo -e "${red}yay${coloroff}  - ${green}Yay (Yet Another Yogurt)${coloroff}";
		read -p 'Enter your selection: ' HELPER
		case ${HELPER} in
			"paru" | "Paru" | "PARU")
				install_phoenix ${URL}/${SCRIPT[0]} ${SCRIPT[0]}
				;;
			"yay" | "Yay" | "YAY")
				install_phoenix ${URL}/${SCRIPT[1]} ${SCRIPT[1]}
				;;
		esac
		;;

	"debian" | "Debian" | "DEBIAN")
		install_phoenix ${URL}/${SCRIPT[2]} ${SCRIPT[2]}
		;;

	"fedora" | "Fedora" | "FEDORA")
		install_phoenix ${URL}/${SCRIPT[3]} ${SCRIPT[3]}
		;;

	"macOS" | "macos" | "MacOS" | "MACOS")
		install_phoenix ${URL}/${SCRIPT[4]} ${SCRIPT[4]}
		;;
esac
