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
    ./mac-apps.nix
    ./macos-packages.nix
    ./nix.nix
  ];

  environment.shells = with pkgs; [
    bashInteractive
    zsh
  ];


  environment.systemPackages = with pkgs; [
    vim
  ];

  programs.bash.enable = true;
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
