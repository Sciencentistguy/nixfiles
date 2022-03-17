{ pkgs, overrides, ... }: {
  home.packages = [
    pkgs.nix # nix package manager
  ];
}
