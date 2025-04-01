{pkgs, ...}: {
  imports = [
    ./base.nix
    ./config.nix
    ./gpg.nix
    ./users.nix
  ];

  programs.zsh.enable = true;
}
