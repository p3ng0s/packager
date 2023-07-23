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

mkdir repo
repo-add -n repo/p3ng0s.db.tar.gz $(find . -name "*.tar.zst")

mv */*.tar.zst ./repo/
