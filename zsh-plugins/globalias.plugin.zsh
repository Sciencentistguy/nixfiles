globalias() {
    zle _expand_alias
    zle self-insert
}

zle -N globalias

bindkey " " magic-space
bindkey "^ " globalias
bindkey -M isearch " " magic-space # normal space during searches
