{ config, pkgs, lib, ... }:

{
  imports = [
    <home-manager/nix-darwin>
    ./jamie.nix
    ./root.nix
  ];

  #environment.darwinConfig 
  environment.darwinConfig = "$HOME/.nix-environment/darwin.nix";

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
    "firefox"
    "gitkraken"
    "ghidra"
    "google-drive"
    "keybase"
    "multimc"
    "private-internet-access"
    "qbittorrent"
    "spotify"
    "steam"
    "visual-studio-code"
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

  #home-manager.users.root = import ./root.nix;
  #home-manager.users.jamie = import ./jamie.nix;


  users.users.jamie =
    {
      name = "jamie";
      home = "/Users/jamie";
    };
}
