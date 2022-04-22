{pkgs, ...}: {
  home.packages = with pkgs; [
    comma
    nix-index
  ];
}
