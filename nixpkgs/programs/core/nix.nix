{ pkgs, ... }: {
  home.packages = with pkgs; [ nix ];
  xdg.enable = true;
  xdg.configFile."nixpkgs/config.nix".source = ./../../config.nix;
}

