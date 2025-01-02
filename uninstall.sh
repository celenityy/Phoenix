#!/bin/bash

## Downloaded files save in /tmp
cd /tmp

## Colours
blue='\e[1;34m';
brown='\e[0;33m';
coloroff='\e[0m'; # Colour off
cyan='\e[1;36m';
gray='\e[1;30m';
green='\e[0;32m';
purple='\e[0;35m';
red='\e[1;31m';

## Download and run uninstall script
uninstall_phoenix() {
	wget -nv $1
	echo
	echo
	sudo bash $2
}

## Scripts are here
URL="https://phoenix.celenity.dev/uninstaller_scripts"

## Scripts file
SCRIPT=("arch_uninstall_paru.sh"
		"arch_uninstall_yay.sh"
		"debian_uninstall.sh"
		"fedora_uninstall.sh"
		"macos_uninstall.sh")

echo -e "${purple}Welcome to the Phoenix uninstaller!${coloroff}";
echo -e "${purple}We're sorry to see you go :(${coloroff}";
echo -e "";
echo -e "${brown}To begin, please choose your platform.${coloroff}";
echo -e "${brown}Your options are:${coloroff}";
echo -e "${cyan}arch${coloroff}   - ${green}Arch Linux (AUR)${coloroff}";
echo -e "${red}debian${coloroff} - ${green}Debian GNU/Linux & Derivatives (openSUSE Build System)${coloroff}";
echo -e "${blue}fedora${coloroff} - ${green}Fedora Linux (COPR)${coloroff}";
echo -e "${gray}macOS${coloroff}  - ${green}macOS (Homebrew)${coloroff}";
read -p 'Enter your selection: ' DISTRO

case ${DISTRO} in

	"arch" | "Arch" | "ARCH")
		echo -e "";
		echo -e "${brown}Please choose your AUR helper.${coloroff}";
		echo -e "${brown}Your options are:${coloroff}";
		echo -e "${blue}paru${coloroff} - ${green}Paru${coloroff}";
		echo -e "${red}yay${coloroff}  - ${green}Yay (Yet Another Yogurt)${coloroff}";
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
