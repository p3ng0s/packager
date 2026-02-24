#!/bin/bash
# setup.sh
# Created on: Fri 21 Jul 2023 04:19:21 PM CEST
#
#  ____   __  ____  __
# (  _ \ /. |(  _ \/  )
#  )___/(_  _))___/ )(
# (__)    (_)(__)  (__)
#
# Description:
#  A bash script that will build all my packages for p3ng0s
# Usage:

#AUR=("https://aur.archlinux.org/scala.git" \
#	"https://aur.archlinux.org/python-bloodhound.git" "https://aur.archlinux.org/emojify.git"\
#	"https://aur.archlinux.org/calamares.git" "https://aur.archlinux.org/ckbcomp.git" \
#	"https://aur.archlinux.org/mkinitcpio-openswap.git" "https://aur.archlinux.org/responder.git" \
#	"https://aur.archlinux.org/font-symbola.git" "https://aur.archlinux.org/python-minikerberos.git" \
#	"https://aur.archlinux.org/python-msldap.git" "https://aur.archlinux.org/python-asysocks.git" \
#	"https://aur.archlinux.org/python-pypykatz.git" "https://aur.archlinux.org/python-winacl.git" \
#	"https://aur.archlinux.org/python-winsspi.git" "https://aur.archlinux.org/python-aiosmb.git" \
#	"https://aur.archlinux.org/python-aiowinreg.git" "https://aur.archlinux.org/python-aesedb.git" \
#	"https://aur.archlinux.org/python-unicrypto.git" "https://aur.archlinux.org/python-asyauth.git" \
#	"https://aur.archlinux.org/i3lock-fancy-git.git" "https://aur.archlinux.org/dracula-gtk-theme.git" \
#	"https://aur.archlinux.org/ckbcomp.git" "https://aur.archlinux.org/mkinitcpio-openswap.git" \
#	"https://aur.archlinux.org/dislocker.git")
#	"https://aur.archlinux.org/ruby-evil-winrm.git" "https://aur.archlinux.org/ruby-winrm.git" "https://aur.archlinux.org/ruby-winrm-fs.git")
# ============================================================================
# The AUR links for some packages ^^
# ============================================================================
AUR=("https://aur.archlinux.org/i3lock-fancy-git.git" "https://aur.archlinux.org/dracula-gtk-theme.git"\
	"https://aur.archlinux.org/emojify.git" "https://aur.archlinux.org/xautolock.git"\
	"https://aur.archlinux.org/conquest-git.git")
# ============================================================================


function usage() {
	echo -e "\e[1;31mUsage:\e[m" 1>&2
	echo "$0 -b -> Build only." 1>&2
	echo "$0 -c -> Clean" 1>&2
	echo "$0 -s -> Skip the AUR" 1>&2
	echo -e "\e[1;31mExamples:\e[m" 1>&2
	echo "$0" 1>&2
	echo "$0 -b" 1>&2
	echo "$0 -c" 1>&2
	echo "$0 -s -b" 1>&2
	exit -1
}

function get_aur() {
	for u in ${AUR[*]}; do
		git clone $u
	done
}

function build() {
	REPOS=( $(find -type d | grep -wv "\./\.*" | grep -wv "\.git" | tail -n +2) )

	for d in ${REPOS[*]}; do
		SAVE_TMP=$(pwd)
		cd $d
		makepkg
		cd $SAVE_TMP
	done
}

function clean() {
	rm -rf */src/
	rm -rf */pkg/
	rm -rf ./repo/
	# remove AUR
	rm -rf dracula-gtk-theme/ emojify/ i3lock-fancy-git/ xautolock/ conquest-git/
}

SKIP_AUR=false

while getopts "bcsr" opt; do
	case $opt in
		b)
			build
			;;
		c)
			clean
			exit
			;;
		r)
			clean
			rm -rf ./repo
			exit
			;;
		s)
			SKIP_AUR=true
			;;
		*)
			usage
			;;
	esac
done
shift $((OPTIND -1))

if [ "$SKIP_AUR" = false ]; then
	get_aur
fi

build

mkdir repo
repo-add -n repo/p3ng0s.db.tar.gz $(find . -name "*.tar.zst")
mv */*.tar.zst ./repo/
cp -r ./repo/calamares*.pkg.tar.zst ./calamares/

exit
