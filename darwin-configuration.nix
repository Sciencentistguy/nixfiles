{ config, pkgs, lib, ... }:

let custompkgs = import
  (fetchTarball {
    url = "https://github.com/Sciencentistguy/nixpkgs/archive/974a87b25f6d2d3398b3c71138bc2de7ddc094d3.tar.gz";
    sha256 = "16m1lbbk1mg1bjahhxln2gxa7hd47c6pi7h5kjg9dzvbz1h0s65m";
  })
  { };
in
{
  imports = [ <home-manager/nix-darwin> ];
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget

  nix.trustedUsers = [
    "jamie"
  ];

  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  environment.systemPackages = [
    pkgs.coreutils

    pkgs.neovim
    pkgs.nodejs
    pkgs.yarn
  ];

  environment.shells = with pkgs; [
    bashInteractive
    zsh
  ];

  # --------
  # homebrew
  # --------

  homebrew.enable = true;
  homebrew.autoUpdate = true;
  homebrew.cleanup = "zap";
  homebrew.global.brewfile = true;
  homebrew.global.noLock = true;

  homebrew.taps = [
    "homebrew/cask"
    "homebrew/cask-drivers"
    "homebrew/cask-fonts"
    "homebrew/cask-versions"
    "homebrew/core"
    "homebrew/services"
    "nrlquaker/createzap"
  ];

  homebrew.masApps = {
    Keynote = 409183694;
    Numbers = 409203825;
    Pages = 409201541;
    Slack = 803453959;
    #Xcode = 497799835;
  };

  homebrew.casks = [
    "discord"
    "keybase"
    "google-drive"
    "steam"
    "visual-studio-code"
    "multimc"
    "gitkraken"
    "firefox"
    "private-internet-access"
    "qbittorrent"
  ];

  homebrew.brews = [

  ];


  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  users.users.root =
    {
      name = "root";
      home = "/var/root";
    };

  home-manager.users.root = { pkgs, ... }: {
    home.packages = [
      pkgs.exa
    ];

    programs.bash.enable = true;
    programs.zsh.enable = true;
    programs.zsh.enableCompletion = true;
    programs.zsh.enableAutosuggestions = true;
    programs.zsh.enableSyntaxHighlighting = true;
    programs.zsh.shellAliases = {
      ls = "exa -lhgbHm --git ";
      lst = "exa -lhgbHmT --git --git-ignore";
      lstg = "exa -lhgbHmT --git";
      lsa = "exa -lhgbHma --git";
      lsat = "exa -lhgbHmaT --git";
    };

    programs.starship.package = custompkgs.starship;
    programs.starship.enable = true;
    programs.starship.enableZshIntegration = true;
    programs.starship.enableBashIntegration = true;
  };

  users.users.jamie =
    {
      name = "jamie";
      home = "/Users/jamie";
    };


  home-manager.users.jamie = { pkgs, ... }: {
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

    #programs.bash.enable = true;
    #programs.neovim.enable = true;
  };
}
