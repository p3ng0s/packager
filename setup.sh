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
#

AUR=("https://aur.archlinux.org/scala.git" \
	"https://aur.archlinux.org/python-bloodhound.git" "https://aur.archlinux.org/emojify.git"\
	"https://aur.archlinux.org/calamares.git" "https://aur.archlinux.org/ckbcomp.git" \
	"https://aur.archlinux.org/mkinitcpio-openswap.git" "https://aur.archlinux.org/responder.git" \
	"https://aur.archlinux.org/font-symbola.git" "https://aur.archlinux.org/python-minikerberos.git" \
	"https://aur.archlinux.org/python-msldap.git" "https://aur.archlinux.org/python-asysocks.git" \
	"https://aur.archlinux.org/python-pypykatz.git" "https://aur.archlinux.org/python-winacl.git" \
	"https://aur.archlinux.org/python-winsspi.git" "https://aur.archlinux.org/python-aiosmb.git" \
	"https://aur.archlinux.org/python-aiowinreg.git" "https://aur.archlinux.org/python-aesedb.git" \
	"https://aur.archlinux.org/python-unicrypto.git" "https://aur.archlinux.org/python-asyauth.git" \
	"https://aur.archlinux.org/i3lock-fancy-git.git" "https://aur.archlinux.org/dracula-gtk-theme.git" \
	"https://aur.archlinux.org/ckbcomp.git" "https://aur.archlinux.org/mkinitcpio-openswap.git" \
	"https://aur.archlinux.org/dislocker.git")
#	"https://aur.archlinux.org/ruby-evil-winrm.git" "https://aur.archlinux.org/ruby-winrm.git" "https://aur.archlinux.org/ruby-winrm-fs.git")

# For now fuck AUR lets see if we can setup everything properly first then have AUR built differently
#for u in ${AUR[*]}; do
#	git clone $u
#done

REPOS=( $(find -type d | grep -wv "\./\.*" | grep -wv "\.git" | tail -n +2) )

for d in ${REPOS[*]}; do
	SAVE_TMP=$(pwd)
	cd $d
	makepkg
	cd $SAVE_TMP
done

mkdir repo
repo-add -n repo/p3ng0s.db.tar.gz $(find . -name "*.tar.zst")

mv */*.tar.zst ./repo/

rm -rf */src/
rm -rf */pkg/
