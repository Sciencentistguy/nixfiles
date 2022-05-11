{
  pkgs,
  systemName,
  lib,
  ...
}: {
  imports =
    [
      ./atuin.nix
      ./coreutils.nix
      ./git.nix
      ./home-manager.nix
      ./neovim.nix
      ./nix.nix
      ./openssh.nix
      ./starship.nix
    ]
    ++ lib.optionals (systemName == "chronos") [
      ./gtk-theme.nix
    ];
}
