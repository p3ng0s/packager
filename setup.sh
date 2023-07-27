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

AUR=("https://aur.archlinux.org/neo4j-community.git" "https://aur.archlinux.org/python-bloodhound.git" \
	"https://aur.archlinux.org/calamares.git" "https://aur.archlinux.org/ckbcomp.git" \
	"https://aur.archlinux.org/mkinitcpio-openswap.git" "https://aur.archlinux.org/responder.git")
#	"https://aur.archlinux.org/python-pypykatz.git" "https://aur.archlinux.org/crackmapexec.git")

for u in ${AUR[*]}; do
	git clone $u
done

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
