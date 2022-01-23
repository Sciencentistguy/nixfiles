let custompkgs = import ./custompkgs.nix { };
in
{ ... }:
{
  home-manager.users.jamie = { pkgs, lib, ... }:
    let isDarwin = pkgs.stdenv.isDarwin;
    in
    {
      home.packages = [
        # Store shell history in a SQL database
        pkgs.atuin

        # A good process monitor (python version is more stable on darwin)
        pkgs.bpytop
        pkgs.btop

        # A prettifier for diffs
        pkgs.delta

        # Fancier `ls`
        pkgs.exa

        # Fancier `find`
        pkgs.fd

        # Video encoder
        pkgs.ffmpeg

        # PGP implementation
        pkgs.gnupg

        # Flex mode
        pkgs.neofetch

        # Format nix source code
        pkgs.nixpkgs-fmt

        # General purpse archive extractor
        pkgs.p7zip

        # Reverse engineering tool
        pkgs.radare2

        # Good grep
        pkgs.ripgrep
        pkgs.ripgrep-all

        # Language server for nix
        pkgs.rnix-lsp

        # Speedtest tool
        pkgs.speedtest-cli

        # Terminal multiplexer
        pkgs.tmux

        # Download files
        pkgs.wget

        # Extract xz files
        pkgs.xz

        # Fuzzy finder
        pkgs.fzf

        custompkgs.starship

      ];

      programs.bat.enable = true;
      programs.bat.config = {
        style = "numbers";
      };

      programs.git.enable = true;
      programs.git.delta.enable = true;
      programs.git.ignores = [
        "tags"
        ".vim/"
        ".ccls*/"
        ".clangd"
      ];
      programs.git.signing = {
        key = "30BBFF3FAB0BBB3E0435F83C8E8FF66E2AE8D970";
        signByDefault = true;
      };
      programs.git.userEmail = "jamie@quigley.xyz";
      programs.git.userName = "Jamie Quigley";

      programs.gh.enable = true;
      programs.gh.settings.git_protocol = "ssh";

      programs.ssh.enable = true;
      programs.ssh.compression = true;

      programs.ssh.matchBlocks."github.com".identityFile = "~/.ssh/github";
      programs.ssh.matchBlocks."*.github.com".identityFile = "~/.ssh/github";
      programs.ssh.matchBlocks."gitlab.com".identityFile = "~/.ssh/github";
      programs.ssh.matchBlocks."*.gitlab.com".identityFile = "~/.ssh/github";
      programs.ssh.matchBlocks."seedbox".identityFile = "~/.ssh/seedbox";
      programs.ssh.matchBlocks."aur.archlinux.org".identityFile = "~/.ssh/aur";
      programs.ssh.matchBlocks."*.york.ac.uk".user = "jehq500";

      programs.nushell.enable = true;
      programs.nushell.settings = {
        edit_mode = "vi";
        startup = [
          "def lls [] { clear; ls }"
          "def neofetch [] {clear; ^neofetch}"
          "def mkcdir [p: path] {mkdir $p; cd $p}"
          "def abs [pkg: string] {asp update $pkg; asp checkout $pkg}"
          "def \"cd sd\" [] { cd ~/ScratchArea }"
          "def \"cd dl\" [] {cd ~/Downloads}"
        ];
      };

      programs.bash.enable = true;
      programs.zsh.enable = false;
      programs.zsh.enableCompletion = true;
      programs.zsh.enableAutosuggestions = true;
      programs.zsh.enableSyntaxHighlighting = true;
      programs.zsh.shellAliases = {
        ls = "exa -lhgbHm --git ";
        lst = "exa -lhgbHmT --git --git-ignore";
        lstg = "exa -lhgbHmT --git";
        lsa = "exa -lhgbHma --git";
        lsat = "exa -lhgbHmaT --git";

        ":q" = "exit";
        aria2c = "aria2c --file-allocation=none";
        cp = "cp -av --reflink=auto";
        dc = "cd";
        df = "df -h";
        du = "du -sh";
        e = "nvim $(fzf)";
        feh = "feh --conversion-timeout 1";
        fex = "nautilus . 2>/dev/null";
        ffmpeg = "ffmpeg -hide_banner";
        ffplay = "ffplay -hide_banner";
        ffprobe = "ffprobe -hide_banner";
        gla = "git-pull-all";
        less = "less -r";
        makepkg-gcc = "makepkg --config /etc/makepkg.conf.gcc";
        mc = "make clean";
        mkdir = "mkdir -p";
        mm = "make -j$(nproc)";
        more = "less -r";
        mount = "sudo mount";
        mv = "mv -v";
        neofetch = "clear; neofetch";
        poweroff = "sudo poweroff";
        reboot = "sudo reboot";
        rg = "rg -S";
        rm = "rm -rfv";
        rsync = "rsync -Pva";
        sl = "ls";
        sudo = "sudo ";
        umount = "sudo umount";
        xclip = "xclip -selection clipboard";
        zshrc-reload = "reload-zshrc";
      };

      programs.zsh.shellGlobalAliases = {
        sd = "~/ScratchArea";
        dl = "~/Downloads";
      };

      programs.zsh.completionInit = "autoload -U compinit && compinit -C";
      programs.zsh.initExtraBeforeCompInit = "ZSH_DISABLE_COMPFIX=true";


      programs.zsh.oh-my-zsh.enable = true;
      programs.zsh.oh-my-zsh.plugins = [
        "globalias"
        "git"
      ] ++ lib.optional (!isDarwin) [ "archlinux" ];

      programs.zsh.plugins = [
        {
          name = "zsh-vim-mode";
          src = pkgs.fetchFromGitHub {
            owner = "softmoth";
            repo = "zsh-vim-mode";
            rev = "1f9953b7d6f2f0a8d2cb8e8977baa48278a31eab";
            sha256 = "sha256-a+6EWMRY1c1HQpNtJf5InCzU7/RphZjimLdXIXbO6cQ";
          };
        }
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.4.0";
            sha256 = "037wz9fqmx0ngcwl9az55fgkipb745rymznxnssr3rx9irb6apzg";
          };
        }
        {
          name = "you-should-use";
          src = pkgs.fetchFromGitHub {
            owner = "MichaelAquilina";
            repo = "zsh-you-should-use";
            rev = "773ae5f414b296b4100f1ab6668ecffdab795128";
            sha256 = "sha256-g4Fw0TwyajZnWQ8fvJvobyt98nRgg08uxK6yNEABo8Y";
          };
        }
      ];

      # This binds <Up> to <C-r> which i don't want
      #programs.atuin.enable = true;
      #programs.atuin.enableZshIntegration = true;

      programs.atuin.settings = {
        search_mode = "fulltext";
      };

      programs.zsh.initExtra = ''
        export ATUIN_NOBIND=true
        eval "$(atuin init zsh)"

        bindkey '^r' _atuin_search_widget

        # depends on terminal mode
        #bindkey '^[[A' _atuin_search_widget
        #bindkey '^[OA' _atuin_search_widget

        unset __ETC_ZSHENV_SOURCED
        source /etc/zshenv
      '';

      programs.starship.package = custompkgs.starship;
      programs.starship.enable = true;
      programs.starship.enableZshIntegration = true;
      programs.starship.enableBashIntegration = true;
      programs.starship.settings = {
        add_newline = false;
        format = "$all";
        character = {
          success_symbol = "[<I>](bold fg:246) [➜](bold green)";
          cancel_symbol = "[<I>](bold fg:246) [➜](bold yellow)";
          error_symbol = "[<I>](bold fg:246) [➜](bold red)";
          vicmd_success_symbol = "[<N>](bold fg:246) [➜](bold green)";
          vicmd_cancel_symbol = "[<N>](bold fg:246) [➜](bold yellow)";
          vicmd_error_symbol = "[<N>](bold fg:246) [➜](bold red)";
        };
        aws = {
          disabled = true;
        };
        battery = {
          disabled = !isDarwin;
        };
        cmd_duration = {
          min_time = 5000;
          show_milliseconds = true;
        };
        directory = {
          truncation_length = 8;
          truncate_to_repo = true;
          read_only = " 🔒";
        };
        hostname = {
          ssh_only = false;
        };
        username = {
          show_always = true;
          format = "[$user]($style)@";
        };
        package = {
          disabled = true;
        };
        cmake =
          if isDarwin then {
            symbol = "🛆 ";
          } else
            { };
        nix_shell = {
          impure_msg = "";
          pure_msg = "";
          format = "within [$symbol($name)]($style) ";
        } // (if (!isDarwin) then {
          symbol = " ";
        } else { });
      };


      #programs.bash.enable = true;
      #programs.neovim.enable = true;
    };
}
# vim: ft=nix


