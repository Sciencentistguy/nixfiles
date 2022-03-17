{ pkgs, lib, ... }:
{
  imports = [
    ./bat.nix
    ./git.nix
    ./linux-only.nix
    ./neovim.nix
    ./nix.nix
    ./nushell.nix
    ./overrides.nix
    ./packages.nix
    ./ssh.nix
    ./starship.nix
    # ./zsh.nix
  ];
}
