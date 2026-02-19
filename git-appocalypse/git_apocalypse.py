#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Made by papi
# Created on: Mon 16 Feb 2026 08:52:34 PM CET
# git_appocalypse.py
# Description:

import os, json, git
import argparse

class CloneProgress(git.RemoteProgress):
    def update(self, op_code, cur_count, max_count=None, message=''):
        if message:
            print(f"Status: {message} ({cur_count}/{max_count or '?'})")

def clone_git_repo(repo_url, target_dir):
    try:
        git.Repo.clone_from(repo_url, target_dir, progress=CloneProgress())
    except git.exc.GitCommandError as e:
        print(f"Error: {e}")

def install_tool(tool, install_dir):
    original_dir = os.getcwd()
    try:
        os.chdir(install_dir)
        for cmd in tool["install"]:
            print("\x1b[1;31m[!]\x1b[0m Running %s on %s:" % (cmd, tool["name"]))
            os.system(cmd)
    finally:
        os.chdir(original_dir)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="The apocalypse of git")
    parser.add_argument(
        "-d", "--dir",
        help="The target directory (default: current directory)"
    )
    # 3. Parse the arguments
    args = parser.parse_args()

    os.makedirs(args.dir+"/opt/pentest", exist_ok=True)
    os.makedirs(args.dir+"/opt/dev", exist_ok=True)
    os.makedirs(args.dir+"/opt/windows", exist_ok=True)

    with open ("./tools.json", "r") as fp:
        data = json.load(fp)
    print("\x1b[1;30m[!]\x1bInstalling Pentesting Things...")
    for tool in data["pentest_tools"]:
        print("\x1b[1;31m[!]\x1b[0m Cloning %s:" % tool["name"])
        clone_git_repo(tool["url"], args.dir+"/opt/pentest/"+tool["name"])
        install_tool(tool, args.dir+"/opt/pentest/"+tool["name"])
    print("\x1b[1;30m[!]\x1bInstalling Dev Tools...")
    for tool in data["dev_tools"]:
        print("\x1b[1;31m[!]\x1b[0m Cloning %s:" % tool["name"])
        clone_git_repo(tool["url"], args.dir+"/opt/dev/"+tool["name"])
        install_tool(tool, args.dir+"/opt/dev/"+tool["name"])
    print("\x1b[1;30m[!]\x1bInstalling Windows Tools...")
    for tool in data["windows_tools"]:
        print("\x1b[1;31m[!]\x1b[0m Cloning %s:" % tool["name"])
        clone_git_repo(tool["url"], args.dir+"/opt/dev/"+tool["name"])
        install_tool(tool, args.dir+"/opt/dev/"+tool["name"])
