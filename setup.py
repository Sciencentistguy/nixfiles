#!/usr/bin/env python3
import os
import subprocess
import sys

yes = "-y" in sys.argv

IS_DARWIN: bool = sys.platform.startswith("darwin")


def mkdir(path: str):
    try:
        os.mkdir(os.path.expanduser(path))
    except FileExistsError:
        pass


def install_packages(packages):
    AUR_HELPER = "pikaur"
    if "--pkg" in sys.argv or "--packages" in sys.argv:
        subprocess.run([AUR_HELPER, "-S", ] + packages)


def install_coc_plugins() -> None:
    def split_list(ls, n):
        for i in range(0, len(ls), n):
            yield ls[i:i + n]

    pluglist = [
        "coc-clangd",
        "coc-css",
        "coc-diagnostic",
        "coc-dictionary",
        "coc-emoji",
        "coc-git",
        "coc-java",
        "coc-json",
        "coc-lists",
        "coc-markdownlint",
        "coc-marketplace",
        "coc-pairs",
        "coc-jedi",
        "coc-rust-analyzer",
        "coc-sh",
        "coc-snippets",
        "coc-tag",
        "coc-texlab",
        "coc-tsserver",
        "coc-ultisnips",
        "coc-vimtex",
        "coc-word",
        "coc-yaml",
        "coc-yank"]

    for plugs in split_list(pluglist, 10):
        subprocess.run(["nvim", "+CocInstall " + " ".join(plugs)])


def link(relative_name: str, filepath: str, /, sudo: bool = False) -> None:
    if not os.path.exists(os.getcwd() + relative_name):
        raise FileNotFoundError("Local filepath does not exist")

    filepath = os.path.expanduser(filepath)
    mkdir(filepath if os.path.isdir(filepath) else os.path.dirname(filepath))
    if sudo:
        subprocess.run(["sudo", "rm", "-rf", filepath])
        subprocess.run(
            ["sudo", "ln", "-s", os.getcwd() + relative_name, filepath])
    else:
        subprocess.run(["rm", "-rf", filepath])
        subprocess.run(["ln", "-s", os.getcwd() + relative_name, filepath])


def should(message: str) -> bool:
    return yes or ("n" not in input(f"{message} (Y/n) ").lower())


using_nix_cfgs = False
if IS_DARWIN:
    using_nix_cfgs = should("Install nix-darwin system configuration")

    if using_nix_cfgs:
        link("/nix-environment", "~/.nix-environment")
        print("Installed nix-environment")


if IS_DARWIN:
    if should("Install alacritty config"):
        link("/alacritty_macos.yml", "~/.config/alacritty/alacritty.yml")

else:
    if should("Install alacritty config"):
        link("/alacritty.yml", "~/.config/alacritty/alacritty.yml")

    if should("Install archlinx specific configs?"):
        link("/makepkg.conf", "/etc/makepkg.conf", sudo=True)
        print("Installed makepkg.conf")
        link("/makepkg.conf.gcc", "/etc/makepkg.conf.gcc", sudo=True)
        print("Installed makepkg.conf.gcc")
        link("/pacman.conf", "/etc/pacman.conf", sudo=True)
        print("Installed pacman.conf")


if should("Install btop config?"):
    install_packages(["btop"])
    link("/btop.conf", "~/.config/btop/btop.conf")
    print("Installed btop.conf")

if should("Install Haskell GHCi config?"):
    mkdir("~/.ghc")
    link("/ghci.conf", "~/.ghc/ghci.conf")
    print("Installed GHCi config")

if (not using_nix_cfgs) and should("Install Git configs"):
    link("/gitignore", "~/.config/git/ignore")
    link("/gitignore", "~/.gitignore")
    print("Installed global gitignore")

if should("Install mpd configs?"):
    link("/mpd/mpd.conf", "~/.config/mpd/mpd.conf")
    print("Installed mpd.conf")
    link("/mpd/mpDris2.conf", "~/.config/mpDris2/mpDris2.conf")
    print("Installed mpDris2.conf")
    link("/mpd/ncmpcpp", "~/.ncmpcpp")
    print("Installed ncmpcpp configs")

if should("Install neofetch config?"):
    mkdir("~/.config/neofetch")
    link("/neofetch.conf", "~/.config/neofetch/config.conf")
    print("Installed neofetch.conf")

if should("Install Nix configs?"):
    link("/nix", "~/.config/nix")
    print("Installed nix config")
    link("/nixpkgs", "~/.config/nixpkgs")
    print("Installed nixpkgs configs and overlays")

if (not using_nix_cfgs) and should("Install nushell config?"):
    mkdir("~/.config/nu")
    link("/nushell.toml", "~/.config/nu/config.toml")
    print("Installed nushell.toml")

if should("Install nvim configs?"):
    install_packages(["neovim-nightly", "vim-plug", "neovim-symlinks",
                     "nodejs", "texlive-bin", "latex-mk", "ccls"])
    link("/nvim", "~/.config/nvim")
    print("Installed nvim configs")
    link("/pylintrc", "~/.pylintrc")
    print("Installed pylintrc")
    install_coc_plugins()
    print("Installed coc.nvim plugins")
    link("/ultisnips", "~/.config/coc/ultisnips")
    print("Installed coc.nvim ultisnips")

if should("Install ptpython configs?"):
    mkdir("~/.config/ptpython")
    link("/ptpython_config.py", "~/.config/ptpython/config.py")
    print("Installed ptpython.py")
    mkdir("~/.config/python")
    link("/pythonstartup.py", "~/.config/python/startup.py")
    print("Installed pythonstartup.py")

if should("Install tmux config?"):
    link("/tmux.conf", "~/.tmux.conf")
    print("Installed tmux.conf")

if should("Install zsh configs?"):
    install_packages(["zsh", "zsh-syntax-highlighting",
                     "zsh-autocomplete", "pkgfile", "starship-git"])
    mkdir("~/.zsh")
    link("/zshrc", "~/.zshrc")
    print("Installed zshrc")
    link("/zsh-plugins", "~/.zsh/plugins")
    print("Installed zsh plugins")
    link("/functions.zsh", "~/.zsh/functions.zsh")
    print("Installed functions.zsh")
    link("/aliases.zsh", "~/.zsh/aliases.zsh")
    print("Installed aliases.zsh")
    if not using_nix_cfgs:
        link("/starship.toml", "~/.config/starship.toml")
        print("Installed starship.toml")
        link("/atuin.toml", "~/.config/atuin/config.toml")
        print("Installed atuin.toml")
