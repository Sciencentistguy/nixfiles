{
  config,
  pkgs,
  lib,
  nixpkgsConfig,
  ...
}: {
  imports = [
    ./gpg.nix
    ./homebrew.nix
    ./nix.nix
  ];

  environment.shells = with pkgs; [
    bashInteractive
    zsh
  ];

  programs.zsh.enable = true; # default shell on catalina

  users.users.root = {
    name = "root";
    home = "/var/root";
  };

  users.users.jamie = {
    name = "jamie";
    home = "/Users/jamie";
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
