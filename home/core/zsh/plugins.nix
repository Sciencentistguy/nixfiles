{
  lib,
  nix-index-unwrapped,
  oh-my-zsh,
  writeTextFile,
  writeZsh,
  zsh-autosuggestions,
  zsh-nix-shell,
  zsh-syntax-highlighting,
  zsh-vi-mode,
}: let
  ifExists = x: lib.optionalString (x != null) x;
  plugins = {
    git = {
      file = "${oh-my-zsh}/share/oh-my-zsh/plugins/git/git.plugin.zsh";
    };
    command-not-found = {
      file = "${nix-index-unwrapped}/etc/profile.d/command-not-found.sh";
    };
    zsh-autosuggestions = {
      file = "${zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh";
    };
    zsh-vi-mode = {
      file = "${zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      after = ''
        bindkey -r '^R'
      '';
    };
    zsh-nix-shell = {
      file = "${zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh";
    };

    globalias = {
      file = "${oh-my-zsh}/share/oh-my-zsh/plugins/globalias/globalias.plugin.zsh";
      after = let
        globalias-filter-values = [
          "cp"
          "df"
          "du"
          "e"
          "feh"
          "ffmpeg"
          "ffplay"
          "ffprobe"
          "less"
          "ls"
          "lsa"
          "lsat"
          "lst"
          "lstg"
          "mkdir"
          "mv"
          "rg"
          "rm"
          "rsync"
          "sudo"
          "vim"
        ];
      in ''
        GLOBALIAS_FILTER_VALUES=( ${lib.concatStringsSep " " globalias-filter-values} )
      '';
    };

    zsh-syntax-highlighting = {
      file = "${zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
      before = let
        zsh_highlight_styles = {
          unknown-token = "fg=#E06C75,bold";
          reserved-word = "fg=#EFC07B";
          suffix-alias = "fg=#98C379,underline";
          global-alias = "fg=#56B6C2";
          precommand = "fg=#98C379,underline";
          autodirectory = "fg=#98C379,underline";
          globbing = "fg=#61AFEF";
          history-expansion = "fg=#61AFEF";
          command-substitution-delimiter = "fg=#C678DD";
          process-substitution-delimiter = "fg=#C678DD";
          back-quoted-argument-delimiter = "fg=#C678DD";
          single-quoted-argument = "fg=#EFC07B";
          double-quoted-argument = "fg=#EFC07B";
          dollar-quoted-argument = "fg=#EFC07B";
          rc-quote = "fg=#56B6C2";
          dollar-double-quoted-argument = "fg=#56B6C2";
          back-double-quoted-argument = "fg=#56B6C2";
          back-dollar-quoted-argument = "fg=#56B6C2";
          redirection = "fg=#EFC07B";
          comment = "fg=#282C34,bold";
          arg0 = "fg=#98C379";
        };
      in ''
        typeset -A ZSH_HIGHLIGHT_STYLES
        ${
          lib.concatStringsSep "\n"
          (lib.mapAttrsToList
            (k: v: ''ZSH_HIGHLIGHT_STYLES[${lib.escapeShellArg k}]=${lib.escapeShellArg v}'')
            zsh_highlight_styles)
        }
      '';
    };
  };

  sourcePlugin = name: value: ''
    if [ -f ${value.file} ]; then
      ${ifExists value.before or null}
      source ${value.file}
      ${ifExists value.after or null}
    else
      echo "Plugin ${name} not found at ${value.file}"
    fi
  '';
in
  writeZsh "plugins.zsh" (
    lib.concatStringsSep "\n" (lib.mapAttrsToList sourcePlugin plugins)
  )
