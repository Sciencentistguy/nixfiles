{pkgs, ...}: {
  imports = [
    ./atuin.nix
    ./coreutils.nix
    ./git.nix
    ./gtk-theme.nix
    ./home-manager.nix
    ./neovim.nix
    ./nix.nix
    ./openssh.nix
    ./starship.nix
  ];
}
