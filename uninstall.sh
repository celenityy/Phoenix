#!/bin/bash

coloroff='\e[0m';
blue='\e[0;34m';
cyan='\e[0;36m';
green='\e[0;32m';
purple='\e[0;35m';
red='\e[0;31m';
white='\e[0;37m';
yellow='\e[0;33m';

## Download and run uninstall script
uninstall_phoenix() {
	wget -nv $1
	echo
	echo
	sudo bash $2
}

## Downloaded files save in /tmp
cd /tmp

## Scripts are here
URL="https://phoenix.celenity.dev/uninstaller_scripts"

## Scripts file
SCRIPT=("arch_uninstall_paru.sh"
		"arch_uninstall_yay.sh"
		"debian_uninstall.sh"
		"fedora_uninstall.sh"
		"macos_uninstall.sh")

echo -e "${purple}Welcome to the Phoenix uninstaller!${coloroff}";
echo -e "${cyan}We're sorry to see you go :(${coloroff}";
echo -e "";
echo -e "${red}To begin, please choose your operating system.${coloroff}";
echo -e "";
echo -e "${purple}Your options are:${coloroff}";
echo -e "";
echo -e "${cyan}arch${coloroff} - ${green}Arch Linux${coloroff}";
echo -e "${yellow}debian${coloroff} - ${green}Debian (& Derivatives, such as Ubuntu)${coloroff}";
echo -e "${blue}fedora${coloroff} - ${green}Fedora Linux${coloroff}";
echo -e "${white}macOS${coloroff} - ${green}macOS${coloroff}";
read -p 'Enter your selection: ' DISTRO

case ${DISTRO} in

	"arch" | "Arch" | "ARCH")
		echo -e "${red}Please choose your AUR helper.${coloroff}";
		echo -e "";
		echo -e "${purple}Your options are:${coloroff}";
		echo -e "";
		echo -e "${blue}paru${coloroff} - ${green}Paru${coloroff}";
		echo -e "${yellow}yay${coloroff} - ${green}Yay (Yet Another Yogurt)${coloroff}";
		read -p 'Enter your selection: ' HELPER
		case ${HELPER} in
			"paru" | "Paru" | "PARU")
				uninstall_phoenix ${URL}/${SCRIPT[0]} ${SCRIPT[0]}
				;;
			"yay" | "Yay" | "YAY")
				uninstall_phoenix ${URL}/${SCRIPT[1]} ${SCRIPT[1]}
				;;
		esac
		;;

	"debian" | "Debian" | "DEBIAN")
		uninstall_phoenix ${URL}/${SCRIPT[2]} ${SCRIPT[2]}
		;;

	"fedora"| "Fedora" | "FEDORA")
		uninstall_phoenix ${URL}/${SCRIPT[3]} ${SCRIPT[3]}
		;;

	"macOS" | "macos" | "MacOS" | "MACOS")
		uninstall_phoenix ${URL}/${SCRIPT[4]} ${SCRIPT[4]}
		;;
esac
