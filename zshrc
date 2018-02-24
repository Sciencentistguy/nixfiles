#Init
autoload -U compinit promptinit
autoload -U colors && colors
compinit
promptinit

#Aliases
alias vi="nvim"
alias vim="nvim"
alias install="makepkg -sri"
alias wake="wol 30:5A:3A:04:03:A5"
alias ls="ls -lh --color"
alias rm="rm -rfv"
alias cp="cp -av --reflink=auto"
alias mv="mv -v"
alias du="du -sh"
alias mkdir="mkdir -p"
alias dirs="dirs -v"
alias less="less -r"
alias more="less -r"
alias reboot="sudo reboot"
alias poweroff="sudo poweroff"
alias zshrc-edit="sudo nvim /etc/zsh/zshrc"
alias btrfs-du="btrfs fi du -s --human-readable"
alias btrfs-list="sudo btrfs subvolume list / -t"
alias btrfs-df="btrfs filesystem df /"
alias sudo="sudo "
alias rsync="rsync -Pva"
alias mount="sudo mount"
alias umount="sudo umount"
alias -g sd="~/ScratchArea"
alias -g dl="~/Downloads"
alias sensors="while true; do sensors;sleep 1; done"

if [ -f /usr/bin/exa ]
then 
	unalias ls
	alias ls="exa -lhgbHm@ --git "
fi

#ZSH Style and Options
zstyle ':completion:*' menu select
setopt completealiases
setopt extendedglob
unsetopt nomatch
prompt walters
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/doc/pkgfile/command-not-found.zsh

#Functions
mkcdir ()
{
    mkdir -p -- "$1" &&
    cd -P -- "$1"
}

update-all ()
{
    pacaur -Syu
    sudo pacman -R $(pacman -Qdtq)
    sudo mandb -c
}

fix-permissions ()
{
    find $1 -type d -print0 | xargs -0 sudo chmod 755 
    find $1 -type f -print0 | xargs -0 sudo chmod 644
}

pid ()
{
    ps aux | grep $1
}

encrypt () 
{
    if [ $# -ne 2 ]
    then
    tar c $1 |pv|pixz| gpg -r jamie.e.quigley@gmail.com --encrypt > $1.tar.xz.gpg
    else
    tar c $1 |pv|pixz| gpg -r $2 --encrypt > $1.tar.xz.gpg
    fi
}

sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    elif [[ $BUFFER == $EDITOR\ * ]]; then
        LBUFFER="${LBUFFER#$EDITOR }"
        LBUFFER="sudoedit $LBUFFER"
    elif [[ $BUFFER == sudoedit\ * ]]; then
        LBUFFER="${LBUFFER#sudoedit }"
        LBUFFER="$EDITOR $LBUFFER"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}
zle -N sudo-command-line
bindkey "\e\e" sudo-command-line
bindkey -M vicmd '\e\e' sudo-command-line

#Sourcing
if [ -d /etc/zsh/zshrc.d ]; then
  for file in /etc/zsh/zshrc.d/*; do
    source $file
  done
fi

if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "/ubin" ] ; then
    PATH="/ubin:$PATH"
fi

#Variables
export VISUAL="nvim"
export EDITOR="nvim"
export HISTFILE="~/zfile"

#Alias expansion
globalias() {
   if [[ $LBUFFER =~ ' [A-Za-z0-9]+$' ]]; then
     zle _expand_alias
     zle expand-word
   fi
   zle self-insert
}

zle -N globalias

bindkey " " globalias
bindkey "^ " magic-space           # control-space to bypass completion
bindkey -M isearch " " magic-space # normal space during searches
