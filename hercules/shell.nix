{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [atuin];
  programs.zsh = {
    enable = true;
  };

  home-manager.backupFileExtension = "bak";
  home-manager.users.root = {
    home.stateVersion = "24.11";
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      plugins = [
        {
          name = "zsh-nix-shell";
          src = pkgs.zsh-nix-shell;
          file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.zsh-syntax-highlighting;
          file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
        }
        {
          name = "zsh-autosuggestions";
          src = pkgs.zsh-autosuggestions;
          file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
        }
      ];
      initExtra = ''
               zstyle ':completion:*' matcher-list "" 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
                      zstyle ':completion:*' menu select

                      autoload -U add-zsh-hook

                      export ATUIN_SESSION=$(atuin uuid)
                      export ATUIN_HISTORY="atuin history list"
                      export ATUIN_BINDKEYS="true"

                      _atuin_preexec() {
                          id=$(atuin history start -- "$1")
                          export ATUIN_HISTORY_ID="$id"
                      }

                      _atuin_precmd() {
                          local EXIT="$?"

                          [[ -z "$ATUIN_HISTORY_ID" ]] && return

                          (RUST_LOG=error atuin history end --exit $EXIT -- $ATUIN_HISTORY_ID &) >/dev/null 2>&1
                      }

                      _atuin_search() {
                          emulate -L zsh
                          zle -I

                          # Switch to cursor mode, then back to application
                          echoti rmkx
                          # swap stderr and stdout, so that the tui stuff works
                          # TODO: not this
                          output=$(RUST_LOG=error atuin search -i -- $BUFFER 3>&1 1>&2 2>&3)
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

                      function zvm_after_init() {
                          zvm_bindkey viins '^R' _atuin_search_widget
                          zvm_bindkey vicmd '^R' _atuin_search_widget
                      }

                      zvm_after_init_commands+=(
                          "bindkey '^[[A' up-line-or-search"
                          "bindkey '^[[B' down-line-or-search"
                          "bindkey '^[OH' beginning-of-line"
                          "bindkey '^[OF' end-of-line"
                      )
               unset LC_ALL

        alias -g sd=~/ScratchArea
      '';
      shellAliases = {
        "ls" = "exa -lhgbHm --git";
        "e" = "search-edit";
        "ex" = "extract";
      };
    };
    programs.starship = {
      enable = true;
      settings.container.disabled = true;
      enableZshIntegration = true;
    };
  };

  home-manager.users.jamie = {
    # extraSpecialArgs = [inputs];
    imports = [./beets.nix];
    home.stateVersion = "24.11";
    programs.atuin = {
      enable = true;
      enableZshIntegration = false; # Implemented manually to restore up-arrow
      settings.daemon.enabled = true;
    };
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      plugins = [
        {
          name = "zsh-nix-shell";
          src = pkgs.zsh-nix-shell;
          file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.zsh-syntax-highlighting;
          file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
        }
        {
          name = "zsh-autosuggestions";
          src = pkgs.zsh-autosuggestions;
          file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
        }
      ];
      initExtra = ''
               zstyle ':completion:*' matcher-list "" 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
                      zstyle ':completion:*' menu select

                      autoload -U add-zsh-hook

                      export ATUIN_SESSION=$(atuin uuid)
                      export ATUIN_HISTORY="atuin history list"
                      export ATUIN_BINDKEYS="true"

                      _atuin_preexec() {
                          id=$(atuin history start -- "$1")
                          export ATUIN_HISTORY_ID="$id"
                      }

                      _atuin_precmd() {
                          local EXIT="$?"

                          [[ -z "$ATUIN_HISTORY_ID" ]] && return

                          (RUST_LOG=error atuin history end --exit $EXIT -- $ATUIN_HISTORY_ID &) >/dev/null 2>&1
                      }

                      _atuin_search() {
                          emulate -L zsh
                          zle -I

                          # Switch to cursor mode, then back to application
                          echoti rmkx
                          # swap stderr and stdout, so that the tui stuff works
                          # TODO: not this
                          output=$(RUST_LOG=error atuin search -i -- $BUFFER 3>&1 1>&2 2>&3)
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

                      function zvm_after_init() {
                          zvm_bindkey viins '^R' _atuin_search_widget
                          zvm_bindkey vicmd '^R' _atuin_search_widget
                      }

                      zvm_after_init_commands+=(
                          "bindkey '^[[A' up-line-or-search"
                          "bindkey '^[[B' down-line-or-search"
                          "bindkey '^[OH' beginning-of-line"
                          "bindkey '^[OF' end-of-line"
                      )
               unset LC_ALL

        alias -g sd=~/ScratchArea
      '';
      shellAliases = {
        "ls" = "exa -lhgbHm --git";
        "e" = "search-edit";
        "ex" = "extract";
        "rm" = "rm -rfv";
        "mv" = "mv -v";
        "cp" = "cp --reflink=auto -av";
      };
    };
    programs.starship = {
      enable = true;
      settings.container.disabled = true;
      enableZshIntegration = true;
    };

    home.packages =
      (with inputs.nixfiles.packages.x86_64-linux; [search-edit extract])
      ++ (with pkgs; [
        mediainfo
      ]);

    programs.tmux = {
      enable = true;
      aggressiveResize = true;
      keyMode = "vi";
      extraConfig = ''
        set -g mouse on
      '';
      historyLimit = 1000000;
    };
  };

  # needed for atuin on zfs
  systemd.user.services.atuin-daemon = {
    enable = true;
    wantedBy = ["default.target"];
    serviceConfig = {
      ExecStart = "${pkgs.atuin}/bin/atuin daemon";
      ProtectHome = "off";
      Restart = "always";
      RestartSec = "5s";
    };
  };

  users.users.root.shell = pkgs.zsh;
}
