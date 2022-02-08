{ config, pkgs, lib, ... }:
let
  # This is cursed but it would appear that's just how flakes be
  custompkgs = import ../custompkgs.nix { };
  overrides = pkgs.callPackage ../overrides.nix {
    inherit custompkgs;
    inherit (pkgs.stdenv) isDarwin;
  };
in
{
  # imports = [ <home-manager/nix-darwin> ];

  #environment.darwinConfig = "$HOME/.nix-environment/darwin.nix";
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin.nix";

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
    #Xcode = 497799835;
  };

  homebrew.casks = [
    "bitwarden"
    "discord"
    "firefox"
    "flameshot"
    "ghidra"
    "gimp"
    "gitkraken"
    "google-drive"
    "intellij-idea-ce"
    "iterm2"
    "keybase"
    "multimc"
    "private-internet-access"
    "qbittorrent"
    "spotify"
    "steam"
    "temurin"
    "temurin8"
    "tidal"
    "visual-studio-code"
    "vlc"
  ];

  homebrew.brews = [
    "llvm@13"
  ];

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

  users.users.jamie =
    {
      name = "jamie";
      home = "/Users/jamie";
    };


}
