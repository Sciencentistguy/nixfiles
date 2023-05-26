{
  pkgs,
  systemName,
  lib,
  ...
}: {
  imports =
    [
      ./agenix.nix
      ./atuin.nix
      ./coreutils.nix
      ./git.nix
      ./home-manager.nix
      ./neovim
      ./nix.nix
      ./openssh
      ./starship.nix
      ./zsh
    ]
    ++ lib.optionals (systemName == "chronos") [
      ./gtk-theme.nix
    ];
}
