#!/bin/python3
import os
import subprocess
import sys

yes = "-y" in sys.argv


def mkdir(path: str):
    try:
        os.mkdir(os.path.expanduser(path))
    except FileExistsError:
        pass


def pikaur(packages: list):
    if "--pkg" in sys.argv or "--packages" in sys.argv:
        subprocess.run(["pikaur", "-S", ] + packages)


def coc_plugins():
    pluglist = [
        "coc-vimtex",
        "coc-python",
        "coc-json",
        "coc-java",
        "coc-html",
        "coc-css",
        "coc-ccls",
        "coc-snippets",
        "coc-ultisnips",
        "coc-word",
        "coc-emoji",
        "coc-git"]
    subprocess.run(["nvim", "+CocInstall " + " ".join(pluglist)])


def link(relative_name, filepath, sudo=False):
    if not os.path.exists(os.getcwd() + relative_name):
        raise FileNotFoundError("Local filepath does not exist")

    filepath = os.path.expanduser(filepath)
    mkdir(filepath if os.path.isdir(filepath) else os.path.dirname(filepath))
    if sudo:
        subprocess.run(["sudo", "rm", "-rf", filepath])
        subprocess.run(["sudo", "ln", "-s", os.getcwd() + relative_name, filepath])
    else:
        subprocess.run(["rm", "-rf", filepath])
        subprocess.run(["ln", "-s", os.getcwd() + relative_name, filepath])


def should(message: str) -> bool:
    return yes or ("n" not in input(f"{message} (Y/n) ").lower())


if should("Install alacritty config"):
    link("/alacritty.yml", "~/.config/alacritty/alacritty.yml")

if should("Install firefox configs"):
    pikaur(["firefox-tridactyl-native", "firefox"])
    link("/tridactylrc", "~/.config/tridactyl/tridactylrc")
    print("Installed tridactylrc")

if should("Install Git configs"):
    link("/gitignore", "~/.config/git/ignore")
    link("/gitignore", "~/.gitignore")
    print("Installed global gitignore")

if should("Install i3 configs?"):
    pikaur(["i3-gaps", "polybar", "rofi", "compton", "feh", "dunst"])
    link("/i3", "~/.config/i3")
    print("Installed i3 configs")
    link("/i3/polybar", "~/.config/polybar")
    print("Installed polybar configs")
    link("/i3/compton.conf", "~/.config/compton.conf")
    print("Installed compton.conf")
    link("/i3/dunst", "~/.config/dunst")
    print("installed dunst configs")

if should("Install neofetch config?"):
    mkdir("~/.config/neofetch")
    link("/neofetch.conf", "~/.config/neofetch/config.conf")
    print("Installed neofetch.conf")

if should("Install nvim configs?"):
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

if should("Install spicetify themes?"):
    pikaur(["spotify", "spicetify-cli"])
    link("/spicetify/Themes", "~/.config/spicetify/Themes")
    link("/spicetify/config.ini", "~/.config/spicetify/config.ini")
    print("Installed spicetify configs")

if should("Install zsh configs?"):
    pikaur(["zsh", "zsh-syntax-highlighting", "zsh-autocomplete", "pkgfile"])
    mkdir("~/.zsh")
    link("/zshrc", "~/.zshrc")
    print("Installed zshrc")
    link("/zsh-plugins", "~/.zsh/plugins")
    print("Installed zsh plugins")
    link("/functions.zsh", "~/.zsh/functions.zsh")
    print("Installed functions.zsh")
    link("/aliases.zsh", "~/.zsh/aliases.zsh")
    print("Installed aliases.zsh")
    if not os.path.isdir(os.path.expanduser("~/.resh")):
        os.system("curl -fsSL https://raw.githubusercontent.com/curusarn/resh/master/scripts/rawinstall.sh | bash")
        print("Installed resh")
