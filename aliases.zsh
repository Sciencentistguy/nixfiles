# Aliases
alias :q="exit"
alias aria2c="aria2c --file-allocation=none"
alias cp="cp -av --reflink=auto"
alias dc="cd"
alias df="df -h"
alias du="du -sh"
alias e='nvim $(fzf)'
alias feh="feh --conversion-timeout 1"
alias fex="nautilus . 2>/dev/null"
alias ffmpeg="ffmpeg -hide_banner"
alias ffplay="ffplay -hide_banner"
alias ffprobe="ffprobe -hide_banner"
alias gla="git-pull-all"
alias less="less -r"
alias makepkg-gcc="makepkg --config /etc/makepkg.conf.gcc"
alias mc="make clean"
alias mkdir="mkdir -p"
alias mm="make -j$(nproc)"
alias more="less -r"
alias mount="sudo mount"
alias mv="mv -v"
alias neofetch="clear; neofetch"
alias poweroff="sudo poweroff"
alias reboot="sudo reboot"
alias rg="rg -S"
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
    alias lst="exa -lhgbHmT --git --git-ignore"
    alias lstg="exa -lhgbHmT --git"
    alias lsa="exa -lhgbHma --git"
    alias lsat="exa -lhgbHmaT --git"
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
