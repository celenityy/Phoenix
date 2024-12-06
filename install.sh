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
				install_phoenix ${URL}/${SCRIPT[0]} ${SCRIPT[0]}
				;;
			"Paru")
				install_phoenix ${URL}/${SCRIPT[0]} ${SCRIPT[0]}
				;;
			"PARU")
				install_phoenix ${URL}/${SCRIPT[0]} ${SCRIPT[0]}
				;;
			"yay")
				install_phoenix ${URL}/${SCRIPT[1]} ${SCRIPT[1]}
				;;
			"Yay")
				install_phoenix ${URL}/${SCRIPT[1]} ${SCRIPT[1]}
				;;
			"YAY")
				install_phoenix ${URL}/${SCRIPT[1]} ${SCRIPT[1]}
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
				install_phoenix ${URL}/${SCRIPT[0]} ${SCRIPT[0]}
				;;
			"Paru")
				install_phoenix ${URL}/${SCRIPT[0]} ${SCRIPT[0]}
				;;
			"PARU")
				install_phoenix ${URL}/${SCRIPT[0]} ${SCRIPT[0]}
				;;
			"yay")
				install_phoenix ${URL}/${SCRIPT[1]} ${SCRIPT[1]}
				;;
			"Yay")
				install_phoenix ${URL}/${SCRIPT[1]} ${SCRIPT[1]}
				;;
			"YAY")
				install_phoenix ${URL}/${SCRIPT[1]} ${SCRIPT[1]}
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
				install_phoenix ${URL}/${SCRIPT[0]} ${SCRIPT[0]}
				;;
			"Paru")
				install_phoenix ${URL}/${SCRIPT[0]} ${SCRIPT[0]}
				;;
			"PARU")
				install_phoenix ${URL}/${SCRIPT[0]} ${SCRIPT[0]}
				;;
			"yay")
				install_phoenix ${URL}/${SCRIPT[1]} ${SCRIPT[1]}
				;;
			"Yay")
				install_phoenix ${URL}/${SCRIPT[1]} ${SCRIPT[1]}
				;;
			"YAY")
				install_phoenix ${URL}/${SCRIPT[1]} ${SCRIPT[1]}
				;;
		esac
		;;

	"debian")
		install_phoenix ${URL}/${SCRIPT[2]} ${SCRIPT[2]}
		;;

	"Debian")
		install_phoenix ${URL}/${SCRIPT[2]} ${SCRIPT[2]}
		;;

	"DEBIAN")
		install_phoenix ${URL}/${SCRIPT[2]} ${SCRIPT[2]}
		;;

	"fedora")
		install_phoenix ${URL}/${SCRIPT[3]} ${SCRIPT[3]}
		;;

	"Fedora")
		install_phoenix ${URL}/${SCRIPT[3]} ${SCRIPT[3]}
		;;

	"FEDORA")
		install_phoenix ${URL}/${SCRIPT[3]} ${SCRIPT[3]}
		;;

	"macOS")
		install_phoenix ${URL}/${SCRIPT[4]} ${SCRIPT[4]}
		;;

	"macos")
		install_phoenix ${URL}/${SCRIPT[4]} ${SCRIPT[4]}
		;;

	"MacOS")
		install_phoenix ${URL}/${SCRIPT[4]} ${SCRIPT[4]}
		;;

	"MACOS")
		install_phoenix ${URL}/${SCRIPT[4]} ${SCRIPT[4]}
		;;
esac
