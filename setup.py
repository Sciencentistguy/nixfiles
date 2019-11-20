#!/bin/python3
import os
import subprocess
import sys

yes = "-y" in sys.argv


def pikaur(packages: list):
    if "--pkg" in sys.argv or "--packages" in sys.argv:
        subprocess.run(["pikaur", "-S", ] + packages)


def coc_plugins():
    pluglist = ["coc-vimtex", "coc-python", "coc-json", "coc-java", "coc-html", "coc-css", "coc-ccls", "coc-snippets", "coc-ultisnips", "coc-word", "coc-emoji", "coc-git"]
    subprocess.run(["nvim", "+CocInstall " + " ".join(pluglist)])


def link(relative_name, filepath, sudo=False):
    filepath = os.path.expanduser(filepath)
    if sudo:
        subprocess.run(["sudo", "rm", "-rf", filepath])
        subprocess.run(["sudo", "ln", "-s", os.getcwd() + relative_name, filepath])
    else:
        subprocess.run(["rm", "-rf", filepath])
        subprocess.run(["ln", "-s", os.getcwd() + relative_name, filepath])


if yes or ("n" not in input("Install zsh configs? (Y/n) ").lower()):
    pikaur(["zsh", "zsh-syntax-highlighting", "zsh-autocomplete", "pkgfile"])
    link("/zshrc", "~/.zshrc")
    print("Installed zshrc")
    link("/zsh-plugins", "~/.zsh")
    print("Installed .zsh folder")

if yes or ("n" not in input("Install nvim configs? (Y/n) ").lower()):
    pikaur(["neovim-nightly", "vim-plug", "neovim-symlinks", "nodejs", "texlive-bin", "latex-mk", "ccls"])
    try:
        os.mkdir(os.path.expanduser("~/.config/nvim"))
    except OSError:
        pass
    link("/init.vim", "~/.config/nvim/init.vim")
    print("Installed init.vim")
    link("/coc-settings.json", "~/.config/nvim/coc-settings.json")
    print("Installed coc-settings")
    link("/pylintrc", "~/.pylintrc")
    print("Installed pylintrc")
    coc_plugins()
    print("Installed coc.nvim plugins")
    link("/ultisnips", "~/.config/coc/ultisnips")
    print("Installed coc.nvim ultisnips")

if yes or ("n" not in input("Install spicetify configs? (Y/n) ").lower()):
    pikaur(["spotify", "spicetify-cli"])
    link("/spicetify/Themes", "~/.config/spicetify/Themes")
    link("/spicetify/config.ini", "~/.config/spicetify/config.ini")
    print("Installed spicetify configs")

if yes or ("n" not in input("Install i3 configs? (Y/n) ").lower()):
    pikaur(["i3-gaps", "polybar", "rofi", "compton", "feh", "dunst"])
    link("/i3", "~/.config/i3")
    print("Installed i3 configs")
    link("/i3/polybar", "~/.config/polybar")
    print("Installed polybar configs")
    link("/i3/compton.conf", "~/.config/compton.conf")
    print("Installed compton.conf")
    link("/i3/dunst", "~/.config/dunst")
    print("installed dunst configs")

if yes or ("n" not in input("Install pacman.conf? (Y/n) ").lower()):
    link("/pacman.conf", "/etc/pacman.conf", sudo=True)
    print("Installed pacman config")
