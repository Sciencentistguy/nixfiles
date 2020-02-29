# Aliases
alias :q="exit"
alias aria2c="aria2c --file-allocation=none"
alias btrfs-df="btrfs filesystem df /"
alias btrfs-du="btrfs fi du -s --human-readable"
alias btrfs-list="sudo btrfs subvolume list / -t"
alias cp="cp -av --reflink=auto"
alias dc="cd"
alias df="df -h"
alias du="du -sh"
alias fex="nautilus ."
alias ffmpeg="ffmpeg -hide_banner"
alias ffplay="ffplay -hide_banner"
alias ffprobe="ffprobe -hide_banner"
alias less="less -r"
alias mc="make clean"
alias mi="make install"
alias mkdir="mkdir -p"
alias mm="make -j"
alias more="less -r"
alias mount="sudo mount"
alias mv="mv -v"
alias neofetch="clear; neofetch"
alias poweroff="sudo poweroff"
alias reboot="sudo reboot"
alias rm="rm -rfv"
alias rsync="rsync -Pva"
alias sl=ls
alias sudo="sudo "
alias umount="sudo umount"
alias xclip="xclip -selection clipboard"
alias zshrc-reload="reload-zshrc"

# Global Aliases
alias -g sd="~/ScratchArea"
alias -g dl="~/Downloads"
alias -g "..."="../.."
alias -g "...."="../../.."
alias -g "....."="../../../.."

# Conditional Aliases
if type exa >/dev/null; then
    alias ls="exa -lhgbHm --git "
    alias lst="exa -lhgbHmT --git"
    alias lsa="exa -lhgbHma --git"
else
    alias ls="ls -lh --color"
    alias lsa="ls -lhA --color"
fi

if type nvim >/dev/null; then
    alias vi="nvim"
    alias vim="nvim"
    export EDITOR=nvim
    export VISUAL=nvim
elif type vim >/dev/null; then
    alias vi="vim"
    alias nvim="vim"
    export EDITOR=vim
    export VISUAL=vim
else
    alias vim="vi"
    alias nvim="vi"
    export EDITOR=vi
    export VISUAL=vi
fi
if type nvimpager >/dev/null; then
    alias less="nvimpager"
    export PAGER=nvimpager
fi
if type bat >/dev/null; then
    alias cat="PAGER=less bat --color=always"
fi
