#!/bin/python3
import os, subprocess

zshrc = os.path.expanduser("~/.zshrc")
initdotvim = os.path.expanduser("~/.config/nvim/init.vim")
pycodestyle = os.path.expanduser("~/.config/pycodestyle")
i3 = os.path.expanduser("~/.config/i3")
pacman = "/etc/pacman.conf"

if ("n" not in input("Install .zshrc? (Y/n) ").lower()):
    subprocess.run(["rm", "-rf", zshrc])
    subprocess.run(["ln", "-s", os.getcwd() + "/zshrc", zshrc])
    print("Installed zshrc")

if ("n" not in input("Install init.vim? (Y/n) ").lower()):
    try:
        os.makedirs(os.path.expanduser("~/.config/nvim"))
    except OSError:
        pass
    subprocess.run(["rm", "-rf", initdotvim])
    subprocess.run(["ln", "-s", os.getcwd() + "/init.vim", initdotvim])
    print("Installed init.vim")

if ("n" not in input("Install pycodestyle? (Y/n) ").lower()):
    subprocess.run(["rm", "-rf", pycodestyle])
    subprocess.run(["ln", "-s", os.getcwd() + "/pycodestyle", pycodestyle])
    print("Installed pycodestyle")

if ("n" not in input("Install i3 configs? (Y/n) ").lower()):
    subprocess.run(["rm", "-rf", i3])
    subprocess.run(["ln", "-s", os.getcwd() + "/i3", i3])
    print("Installed i3 configs")

if ("n" not in input("Install pacman.conf? (Y/n) ").lower()):
    subprocess.run(["sudo", "rm", "-rf", pacman])
    subprocess.run(["sudo", "ln", "-s", os.getcwd() + "/pacman.conf", pacman])
    print("Installed pacman config")
