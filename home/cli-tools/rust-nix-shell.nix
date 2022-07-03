{flakePkgs, ...}: {
  home.packages = [flakePkgs.rust-nix-shell];
}
