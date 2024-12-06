#!/bin/bash

coloroff='\e[0m';
black='\e[0;30m';
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
echo -e "${cyan}arch${coloroff} - ${red}Arch Linux${coloroff}";
echo -e "${yellow}debian${coloroff} - ${red}Debian (& Derivatives, such as Ubuntu)${coloroff}";
echo -e "${blue}fedora${coloroff} - ${red}Fedora Linux${coloroff}";
echo -e "${white}macOS${coloroff} - ${red}macOS${coloroff}";
read -p 'Enter your selection: ' DISTRO

case ${DISTRO} in

	"arch")
		echo -e "${red}Please choose your AUR helper.${coloroff}";
		echo -e "";
		echo -e "${purple}Your options are:${coloroff}";
		echo -e "";
		echo -e "${blue}paru${coloroff} - ${red}Paru${coloroff}";
		echo -e "${yellow}yay${coloroff} - ${red}Yay (Yet Another Yogurt)${coloroff}";
		read -p 'Enter your selection: ' HELPER
		case ${HELPER} in
			"paru")
				uninstall_phoenix ${URL}/${SCRIPT[0]} ${SCRIPT[0]}
				;;
			"Paru")
				uninstall_phoenix ${URL}/${SCRIPT[0]} ${SCRIPT[0]}
				;;
			"PARU")
				uninstall_phoenix ${URL}/${SCRIPT[0]} ${SCRIPT[0]}
				;;
			"yay")
				uninstall_phoenix ${URL}/${SCRIPT[1]} ${SCRIPT[1]}
				;;
			"Yay")
				uninstall_phoenix ${URL}/${SCRIPT[1]} ${SCRIPT[1]}
				;;
			"YAY")
				uninstall_phoenix ${URL}/${SCRIPT[1]} ${SCRIPT[1]}
				;;
		esac
		;;

	"Arch")
		echo -e "${red}Please choose your AUR helper.${coloroff}";
		echo -e "";
		echo -e "${purple}Your options are:${coloroff}";
		echo -e "";
		echo -e "${blue}paru${coloroff} - ${red}Paru${coloroff}";
		echo -e "${yellow}yay${coloroff} - ${red}Yay (Yet Another Yogurt)${coloroff}";
		read -p 'Enter your selection: ' HELPER
		case ${HELPER} in
			"paru")
				uninstall_phoenix ${URL}/${SCRIPT[0]} ${SCRIPT[0]}
				;;
			"Paru")
				uninstall_phoenix ${URL}/${SCRIPT[0]} ${SCRIPT[0]}
				;;
			"PARU")
				uninstall_phoenix ${URL}/${SCRIPT[0]} ${SCRIPT[0]}
				;;
			"yay")
				uninstall_phoenix ${URL}/${SCRIPT[1]} ${SCRIPT[1]}
				;;
			"Yay")
				uninstall_phoenix ${URL}/${SCRIPT[1]} ${SCRIPT[1]}
				;;
			"YAY")
				uninstall_phoenix ${URL}/${SCRIPT[1]} ${SCRIPT[1]}
				;;
		esac
		;;

	"ARCH")
		echo -e "${red}Please choose your AUR helper.${coloroff}";
		echo -e "";
		echo -e "${purple}Your options are:${coloroff}";
		echo -e "";
		echo -e "${blue}paru${coloroff} - ${red}Paru${coloroff}";
		echo -e "${yellow}yay${coloroff} - ${red}Yay (Yet Another Yogurt)${coloroff}";
		read -p 'Enter your selection: ' HELPER
		case ${HELPER} in
			"paru")
				uninstall_phoenix ${URL}/${SCRIPT[0]} ${SCRIPT[0]}
				;;
			"Paru")
				uninstall_phoenix ${URL}/${SCRIPT[0]} ${SCRIPT[0]}
				;;
			"PARU")
				uninstall_phoenix ${URL}/${SCRIPT[0]} ${SCRIPT[0]}
				;;
			"yay")
				uninstall_phoenix ${URL}/${SCRIPT[1]} ${SCRIPT[1]}
				;;
			"Yay")
				uninstall_phoenix ${URL}/${SCRIPT[1]} ${SCRIPT[1]}
				;;
			"YAY")
				uninstall_phoenix ${URL}/${SCRIPT[1]} ${SCRIPT[1]}
				;;
		esac
		;;

	"debian")
		uninstall_phoenix ${URL}/${SCRIPT[2]} ${SCRIPT[2]}
		;;

	"Debian")
		uninstall_phoenix ${URL}/${SCRIPT[2]} ${SCRIPT[2]}
		;;

	"DEBIAN")
		uninstall_phoenix ${URL}/${SCRIPT[2]} ${SCRIPT[2]}
		;;

	"fedora")
		uninstall_phoenix ${URL}/${SCRIPT[3]} ${SCRIPT[3]}
		;;

	"Fedora")
		uninstall_phoenix ${URL}/${SCRIPT[3]} ${SCRIPT[3]}
		;;

	"FEDORA")
		uninstall_phoenix ${URL}/${SCRIPT[3]} ${SCRIPT[3]}
		;;

	"macOS")
		uninstall_phoenix ${URL}/${SCRIPT[4]} ${SCRIPT[4]}
		;;

	"macos")
		uninstall_phoenix ${URL}/${SCRIPT[4]} ${SCRIPT[4]}
		;;

	"MacOS")
		uninstall_phoenix ${URL}/${SCRIPT[4]} ${SCRIPT[4]}
		;;

	"MACOS")
		uninstall_phoenix ${URL}/${SCRIPT[4]} ${SCRIPT[4]}
		;;
esac
