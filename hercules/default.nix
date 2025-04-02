{pkgs, ...}: {
  imports = [
    ./base.nix
    ./config.nix
    ./gpg.nix
    ./users.nix
    ./i18n.nix
  ];

  programs.zsh.enable = true;
}
