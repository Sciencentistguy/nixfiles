# Init and options
autoload -U compinit promptinit
autoload -U colors && colors
compinit
promptinit

setopt AUTO_PUSHD
setopt SHARE_HISTORY
setopt completealiases
setopt extendedglob

unsetopt nomatch
unsetopt correct
unsetopt correct_all

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000

# Path
# Nix single-user
if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
    source "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

# Nix multi-user
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
    . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
if [ -d "/ubin" ]; then
    PATH="$PATH:/ubin"
fi

if [ -d "/opt/cuda/bin" ]; then
    PATH="$PATH:/opt/cuda/bin"
fi

if [ -d "/sbin" ] && [ ! -L "/sbin" ]; then
    PATH="$PATH:/sbin"
fi

if [ -d "/usr/sbin" ] && [ ! -L "/sbin" ]; then
    PATH="$PATH:/usr/sbin"
fi

if [ -d "$HOME/.gem" ]; then
    for i in $HOME/.gem/ruby/*; do
        PATH="$i/bin:$PATH"
    done
fi

if [ -d "$HOME/.yarn/bin" ]; then
    PATH="$HOME/.yarn/bin:$PATH"
fi

if [ -d "$HOME/.config/yarn/global/node_modules/.bin" ]; then
    PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ]; then
    PATH="$HOME/.cargo/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.bin" ]; then
    PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# Prompt
if type starship >/dev/null; then
    eval "$(starship init zsh)"
    RPROMPT=""
else
    prompt walters
fi

# Aliases
source ~/.zsh/aliases.zsh

# Functions
source ~/.zsh/functions.zsh

# Environment
export GPG_TTY=$(tty)
export MAKEFLAGS="-j$(nproc)"
export NODE_OPTIONS="--max_old_space_size=16384"
export RUST_BACKTRACE=1

if type rg >/dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files'
fi

if type clang >/dev/null; then
    export CC=clang
    export CXX=clang++
fi

if [ -f "$HOME/.config/python/startup.py" ]; then
    export PYTHONSTARTUP="$HOME/.config/python/startup.py"
fi

# esc-esc sudo
sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    elif [[ $BUFFER == $EDITOR\ * ]]; then
        LBUFFER="${LBUFFER#$EDITOR }"
        LBUFFER="sudoedit $LBUFFER"
    elif [[ $BUFFER == vim\ * ]]; then
        LBUFFER="${LBUFFER#vim }"
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

if [ -d /etc/zsh/zshrc.d ]; then
    for file in /etc/zsh/zshrc.d/*; do
        source $file
    done
fi

eval $(ssh-agent) >/dev/null

# Plugins
if [ -f ~/.zsh/plugins/globalias.plugin.zsh ]; then
    source ~/.zsh/plugins/globalias.plugin.zsh
else
    echo "globalias plugin not loaded"
fi

if [ -f ~/.zsh/plugins/git.plugin.zsh ]; then
    source ~/.zsh/plugins/git.plugin.zsh
else
    echo "git plugin not loaded"
fi

if [ -f ~/.zsh/plugins/you-should-use.plugin.zsh ]; then
    source ~/.zsh/plugins/you-should-use.plugin.zsh
else
    echo "you-should-use plugin not loaded"
fi

if [ -f ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
    echo "zsh-syntax-highlighting plugin not loaded"
fi

if [ -f ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
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

if [ -f ~/.zsh/plugins/zsh-vim-mode/zsh-vim-mode.plugin.zsh ]; then
    source ~/.zsh/plugins/zsh-vim-mode/zsh-vim-mode.plugin.zsh
    KEYTIMEOUT=20
    if type starship >/dev/null; then
        RPROMPT=""
    fi
else
    echo "vi-mode plugin not loaded"
fi

if [ -f ~/.zsh/plugins/zsh-nix-shell/nix-shell.plugin.zsh ]; then
    source ~/.zsh/plugins/zsh-nix-shell/nix-shell.plugin.zsh
else
    echo "zsh-nix-shell plugin not loaded"
fi

if type atuin >/dev/null; then
    autoload -U add-zsh-hook

    export ATUIN_SESSION=$(atuin uuid)
    export ATUIN_HISTORY="atuin history list"
    export ATUIN_BINDKEYS="true"

    _atuin_preexec() {
        id=$(atuin history start "$1")
        export ATUIN_HISTORY_ID="$id"
    }

    _atuin_precmd() {
        local EXIT="$?"

        [[ -z "${ATUIN_HISTORY_ID}" ]] && return

        (RUST_LOG=error atuin history end $ATUIN_HISTORY_ID --exit $EXIT &) >/dev/null 2>&1
    }

    _atuin_search() {
        emulate -L zsh
        zle -I

        # Switch to cursor mode, then back to application
        echoti rmkx
        # swap stderr and stdout, so that the tui stuff works
        # TODO: not this
        output=$(RUST_LOG=error atuin search -i $BUFFER 3>&1 1>&2 2>&3)
        echoti smkx

        if [[ -n $output ]]; then
            LBUFFER=$output
        fi

        zle reset-prompt
    }

    add-zsh-hook preexec _atuin_preexec
    add-zsh-hook precmd _atuin_precmd

    zle -N _atuin_search_widget _atuin_search

    if [[ $ATUIN_BINDKEYS == "true" ]]; then
        bindkey '^r' _atuin_search_widget
    fi
fi
