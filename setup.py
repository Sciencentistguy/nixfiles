#!/bin/python3
import os
import subprocess
import sys

yes = "-y" in sys.argv


def package_requirements():
    pkglist = ["nodejs", "texlive-bin", "latex-mk", "ccls", "vim-plug", "neovim", "neovim-symlinks"]
    subprocess.run(["pikaur", "-S"] + pkglist)


def coc_plugins():
    pluglist = ["coc-vimtex", "coc-python", "coc-json", "coc-java", "coc-html", "coc-css", "coc-ccls"]
    subprocess.run(["nvim", "+CocInstall " + " ".join(pluglist)])


def link(filepath, relative_name, sudo=False):
    if sudo:
        subprocess.run(["sudo", "rm", "-rf", filepath])
        subprocess.run(["sudo", "ln", "-s", os.getcwd() + relative_name, filepath])
    else:
        subprocess.run(["rm", "-rf", filepath])
        subprocess.run(["ln", "-s", os.getcwd() + relative_name, filepath])


zshrc = os.path.expanduser("~/.zshrc")
zsh_dir = os.path.expanduser("~/.zsh")
initdotvim = os.path.expanduser("~/.config/nvim/init.vim")
pycodestyle = os.path.expanduser("~/.config/pycodestyle")
i3 = os.path.expanduser("~/.config/i3")
polybar = os.path.expanduser("~/.config/polybar")
pacman = "/etc/pacman.conf"
coc_settings = os.path.expanduser("~/.config/nvim/coc-settings.json")
pylintrc = os.path.expanduser("~/.pylintrc")

if yes or ("n" not in input("Install package dependencies? (Y/n) ")):
    package_requirements()

if yes or ("n" not in input("Install zsh configs? (Y/n) ").lower()):
    link(zshrc, "/zshrc")
    print("Installed zshrc")
    link(zsh_dir, "/zsh-plugins")
    print("Installed .zsh folder")

if yes or ("n" not in input("Install nvim configs? (Y/n) ").lower()):
    try:
        os.makedirs(os.path.expanduser("~/.config/nvim"))
    except OSError:
        pass
    link(initdotvim, "/init.vim")
    print("Installed init.vim")
    link(coc_settings, "/coc-settings.json")
    print("Installed coc-settings")
    link(pylintrc, "/pylintrc")
    print("Installed pylintrc")
    coc_plugins()
    print("Installed coc.nvim plugins")

if yes or ("n" not in input("Install spicetify configs? (Y/n) ").lower()):
    link(os.path.expanduser("~/.config/spicetify/Themes"), "/spicetify/Themes")
    link(os.path.expanduser("~/.config/spicetify/config.ini"), "/spicetify/config.ini")
    print("Installed spicetify configs")

if yes or ("n" not in input("Install i3 configs? (Y/n) ").lower()):
    link(i3, "/i3")
    print("Installed i3 configs")
    link(polybar, "/i3/polybar")
    print("Installed polybar configs")

if yes or ("n" not in input("Install pacman.conf? (Y/n) ").lower()):
    link(pacman, "/pacman.conf", sudo=True)
    print("Installed pacman config")
