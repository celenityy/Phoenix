#!/bin/bash

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
		"fedora_install.sh")

read -p 'What is base of your dirstro(arch, debian, fedora): ' DISTRO

case ${DISTRO} in

	"arch")
		read -p 'What is your AUR helper(paru, yay): ' HELPER

		case ${HELPER} in
			"paru")
				install_phoenix ${URL}/${SCRIPT[0]} ${SCRIPT[0]}
				;;
			"yay")
				install_phoenix ${URL}/${SCRIPT[1]} ${SCRIPT[1]}
				;;
		esac
		;;

	"debian")
		install_phoenix ${URL}/${SCRIPT[2]} ${SCRIPT[2]}
		;;

	"fedora")
		install_phoenix ${URL}/${SCRIPT[3]} ${SCRIPT[3]}
		;;
esac
