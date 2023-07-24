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

REPOS=( $(find -type d | grep -wv "\./\.*" | tail -n +2) )

mkdir repo

for d in ${REPOS[*]}; do
	pwd
	cd $d
	makepkg
	cd ..
	pwd
done

repo-add -n repo/p3ng0s.db.tar.gz $(find . -name "*.tar.zst")

mv */*.tar.zst ./repo/
