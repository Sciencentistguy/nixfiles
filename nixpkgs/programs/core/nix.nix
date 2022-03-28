{ pkgs, ... }: {
  xdg.enable = true;
  xdg.configFile."nixpkgs/config.nix".source = ./../../config.nix;
}

