{pkgs, ...}: {
  xdg.enable = true;
  xdg.configFile."nixpkgs/config.nix".source = ./../../config.nix;
  home.packages = with pkgs; [nix-output-monitor];
}
