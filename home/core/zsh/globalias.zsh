globalias() {
   # Get last word to the left of the cursor:
   # (z) splits into words using shell parsing
   # (A) makes it an array even if there's only one element
   local word=${${(Az)LBUFFER}[-1]}
   if [[ $GLOBALIAS_FILTER_VALUES[(Ie)$word] -eq 0 ]]; then
      zle _expand_alias
      zle expand-word
   fi
   zle self-insert
}
zle -N globalias

# space expands all aliases, including global
bindkey -M emacs " " globalias
bindkey -M viins " " globalias

# control-space to make a normal space
bindkey -M emacs "^ " magic-space
bindkey -M viins "^ " magic-space

# normal space during searches
bindkey -M isearch " " magic-space

# typing "/" after a path-valued global alias expands it, so "cd sd/f" works
globalias-slash() {
   local word=${${(Az)LBUFFER}[-1]}
   if [[ ${galiases[$word]} == (/|\~|.)* ]]; then
      zle _expand_alias
      zle expand-word
   fi
   zle self-insert
}
zle -N globalias-slash

bindkey -M emacs "/" globalias-slash
bindkey -M viins "/" globalias-slash
bindkey -M isearch "/" self-insert
