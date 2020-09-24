# Init and options
autoload -U compinit promptinit
autoload -U colors && colors
compinit
promptinit
prompt spaceship || prompt walters

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

# Prompt
SPACESHIP_PROMPT_ORDER=(
  #time          # Time stamps section
  user          # Username section
  host          # Hostname section
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
  #hg            # Mercurial section (hg_branch  + hg_status)
  #package       # Package version
  #node          # Node.js section
  #ruby          # Ruby section
  #elixir        # Elixir section
  #swift         # Swift section
  #golang        # Go section
  #php           # PHP section
  rust          # Rust section
  haskell       # Haskell Stack section
  #julia         # Julia section
  #docker        # Docker section
  #aws           # Amazon Web Services section
  #gcloud        # Google Cloud Platform section
  venv          # virtualenv section
  #conda         # conda virtualenv section
  #pyenv         # Pyenv section
  #dotnet        # .NET section
  #ember         # Ember.js section
  #kubectl       # Kubectl context section
  #terraform     # Terraform workspace section
  exec_time     # Execution time
  line_sep      # Line break
  #battery       # Battery level and status
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

SPACESHIP_CHAR_SYMBOL="$"
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_CHAR_SYMBOL_ROOT="#"

SPACESHIP_USER_SHOW="always"
#SPACESHIP_USER_SUFFIX=""
SPACESHIP_HOST_SHOW="always"
#SPACESHIP_HOST_PREFIX="@"

SPACESHIP_DIR_TRUNK=0

SPACESHIP_EXEC_TIME_TIME_ELAPSED=5

SPACESHIP_VI_MODE_INSERT="<I>"
SPACESHIP_VI_MODE_NORMAL="<N>"
SPACESHIP_VI_MODE_COLOR=246

# Aliases
source ~/.zsh/aliases.zsh

# Functions
source ~/.zsh/functions.zsh

# Environment
export GPG_TTY=$(tty)

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

# PATH
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

if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ]; then
    PATH="$HOME/.cargo/bin:$PATH"
fi

if [ -d "$HOME/.yarn/bin" ]; then
    PATH="$HOME/.yarn/bin:$PATH"
fi

if [ -d "$HOME/.config/yarn/global/node_modules/.bin" ]; then
    PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
fi

if [ -d "$HOME/.bin" ]; then
    PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

eval $(ssh-agent) >/dev/null

# Plugins
if type thefuck >/dev/null; then
    eval $(thefuck --alias)
fi

if [ -f ~/.zsh/plugins/vi-mode.plugin.zsh ]; then
    source ~/.zsh/plugins/vi-mode.plugin.zsh
else
    echo "vi-mode plugin not loaded"
fi

if grep -Fxq "arch" /etc/os-release; then
    if [ -f ~/.zsh/plugins/git.plugin.zsh ]; then
        source ~/.zsh/plugins/git.plugin.zsh
    else
        echo "archlinux plugin not loaded"
    fi
fi

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

if [ -f ~/.resh/shellrc ]; then
    source ~/.resh/shellrc
fi

if grep -Fxq "arch" /etc/os-release; then
    if [ -f /usr/share/doc/pkgfile/command-not-found.zsh ]; then
        source /usr/share/doc/pkgfile/command-not-found.zsh
    else
        echo "pkgfile plugin not loaded"
    fi
fi
