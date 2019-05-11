#Init
autoload -U compinit promptinit
autoload -U colors && colors
compinit
promptinit

#Aliases
alias vi="nvim"
alias vim="nvim"
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
alias btrfs-du="btrfs fi du -s --human-readable"
alias btrfs-list="sudo btrfs subvolume list / -t"
alias btrfs-df="btrfs filesystem df /"
alias sudo="sudo "
alias rsync="rsync -Pva"
alias mount="sudo mount"
alias umount="sudo umount"
alias -g sd="~/ScratchArea"
alias -g dl="~/Downloads"
alias feh-svg="feh --magick-timeout 1"
alias neofetch="clear; neofetch"
alias aria2c="aria2c --file-allocation=none"
alias nando="nvim"
alias zshrc-reload="reload-zshrc"

eval $(thefuck --alias)


if type exa > /dev/null
then
    alias ls="exa -lhgbHm --git "
fi

alias l=ls
alias s=ls
alias sl=ls

#ZSH Style and Options
zstyle ':completion:*' menu select
    setopt completealiases
    setopt extendedglob
    unsetopt nomatch
    prompt walters

#Functions
mkcdir () {
    mkdir -p -- "$1" &&
        cd -P -- "$1"
    }

reload-zshrc () {
source ~/.zshrc
}

ex () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1   ;;
            *.tar.gz)    tar xzf $1   ;;
            *.tar.xz)    tar xf $1    ;;
            *.bz2)       bunzip2 $1   ;;
            *.rar)       unrar x $1   ;;
            *.gz)        gunzip $1    ;;
            *.tar)       tar xf $1    ;;
            *.tbz2)      tar xjf $1   ;;
            *.tgz)       tar xzf $1   ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1;;
            *.7z)        7z x $1      ;;
            *)           echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# esc-esc sudo
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

if [ -d "$HOME/.bin" ] ; then
    PATH="$HOME/.bin:$PATH"
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

eval $(ssh-agent) > /dev/null

#Alias expansion
#globalias() {
#   if [[ $LBUFFER =~ ' [A-Za-z0-9]+$' ]]; then
    #     zle _expand_alias
    #     zle expand-word
    #   fi
    #   zle self-insert
    #}
    #
    #zle -N globalias
    #
    #bindkey " " globalias
    #bindkey "^ " magic-space           # control-space to bypass completion
    #bindkey -M isearch " " magic-space # normal space during searches

#Sourcing Plugins

if [ -f ~/.zsh/vi-mode.plugin.zsh ]; then
    source ~/.zsh/vi-mode.plugin.zsh
else
    echo "vi-mode plugin not loaded"
fi

if grep -Fxq "arch" /etc/os-release; then
    if [ -f ~/.zsh/git.plugin.zsh ]; then
        source ~/.zsh/git.plugin.zsh
    else
        echo "archlinux plugin not loaded"
    fi
fi

if [ -f ~/.zsh/globalias.plugin.zsh ]; then
    source ~/.zsh/globalias.plugin.zsh
else
    echo "globalias plugin not loaded"
fi

if [ -f ~/.zsh/git.plugin.zsh ]; then
    source ~/.zsh/git.plugin.zsh
else
    echo "git plugin not loaded"
fi

if [ -f ~/.zsh/you-should-use.plugin.zsh ]; then
    source ~/.zsh/you-should-use.plugin.zsh
else
    echo "you-should-use plugin not loaded"
fi

if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
    echo "zsh-syntax-highlighting plugin not loaded"
fi

if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
else
    echo "zsh-autosuggestions plugin not loaded"
fi

if grep -Fxq "arch" /etc/os-release; then
    if [ -f /usr/share/doc/pkgfile/command-not-found.zsh ]; then
        source /usr/share/doc/pkgfile/command-not-found.zsh
    else
        echo "pkgfile plugin not loaded"
    fi
fi

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000
setopt SHARE_HISTORY

