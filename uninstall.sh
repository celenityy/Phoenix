#!/bin/bash

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
		"fedora_uninstall.sh")

read -p 'What is base of your dirstro(arch, debian, fedora): ' DISTRO

case ${DISTRO} in

	"arch")
		read -p 'What is your AUR helper(paru, yay): ' HELPER

		case ${HELPER} in
			"paru")
				uninstall_phoenix ${URL}/${SCRIPT[0]} ${SCRIPT[0]}
				;;
			"yay")
				uninstall_phoenix ${URL}/${SCRIPT[1]} ${SCRIPT[1]}
				;;
		esac
		;;

	"debian")
		uninstall_phoenix ${URL}/${SCRIPT[2]} ${SCRIPT[2]}
		;;

	"fedora")
		uninstall_phoenix ${URL}/${SCRIPT[3]} ${SCRIPT[3]}
		;;
esac
