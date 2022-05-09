{flakePkgs, ...}: {
  home.packages = [flakePkgs.generic-rust-shell];
}
