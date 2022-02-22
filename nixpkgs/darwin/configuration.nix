{ config, pkgs, lib, ... }:
{
  # imports = [ <home-manager/nix-darwin> ];

  #environment.darwinConfig = "$HOME/.nix-environment/darwin.nix";
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin.nix";

  nix.package = pkgs.nix;

  nix.trustedUsers = [
    "jamie"
  ];

  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

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
    Bitwarden = 1352778147;
  };

  homebrew.casks = [
    "discord-canary"
    "firefox"
    "flameshot"
    "ghidra"
    "gimp"
    "gitkraken"
    "google-drive"
    "intellij-idea-ce"
    "iterm2"
    "keybase"
    "logitech-options"
    "mullvadvpn"
    "multimc"
    "plexamp"
    "qbittorrent"
    "rectangle"
    "sonos"
    "spotify"
    "steam"
    "temurin"
    "temurin8"
    "utm"
    "visual-studio-code"
    "vlc"
  ];

  homebrew.brews = [
    "llvm@13"
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

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

  users.users.jamie =
    {
      name = "jamie";
      home = "/Users/jamie";
    };


}
