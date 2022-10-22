{
  lib,
  writeZsh,
}: let
  functions = {
    lls = ''
      clear;
      ls
    '';

    mkcdir = ''
      mkdir -p -- "$1" && cd -P -- "$1"
    '';

    reload-zshrc = ''
      source $HOME/.zshrc
    '';

    imgpaste = ''
      xclip -t image/png -o >$1
    '';

    borderless = ''
      xprop -f _MOTIF_WM_HINTS 32c -set _MOTIF_WM_HINTS "0x2, 0x0, 0x0, 0x0, 0x0"
    '';

    borderless-undo = ''
      xprop -f _MOTIF_WM_HINTS 32c -set _MOTIF_WM_HINTS "0x2, 0x0, 0x1, 0x0, 0x0"
    '';

    ffcompare = ''
      ffplay $1 &
      ffplay $2
    '';

    aur = ''
      git clone "https://aur.archlinux.org/$1"
    '';

    cpufreq = ''
      watch -n0.1 'cat /proc/cpuinfo | grep "^[c]pu MHz" | sort -r'
    '';

    git-pull-all = ''
      for branch in $(git branch --all | grep '^\s*remotes' | egrep --invert-match '(:?HEAD|master)$'); do
          git branch --track "''${branch##*/}" "$branch"
      done
    '';

    sudo-command-line = ''
      [[ -z $BUFFER ]] && zle up-history
      if [[ $BUFFER == sudo\ * ]]; then
          LBUFFER="''${LBUFFER#sudo }"
      elif [[ $BUFFER == $EDITOR\ * ]]; then
          LBUFFER="''${LBUFFER#$EDITOR }"
          LBUFFER="sudoedit $LBUFFER"
      elif [[ $BUFFER == vim\ * ]]; then
          LBUFFER="''${LBUFFER#vim }"
          LBUFFER="sudoedit $LBUFFER"
      elif [[ $BUFFER == sudoedit\ * ]]; then
          LBUFFER="''${LBUFFER#sudoedit }"
          LBUFFER="$EDITOR $LBUFFER"
      else
          LBUFFER="sudo $LBUFFER"
      fi
    '';
  };
in
  writeZsh "functions.zsh" (
    lib.concatStringsSep "\n\n" (lib.mapAttrsToList (k: v: "${k}() {\n${v}\n}") functions)
  )
