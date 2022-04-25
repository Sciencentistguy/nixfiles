{pkgs, flakePkgs, ...}: {
  # TODO: flake this properly
  home.packages = with flakePkgs; [shark-radar];
}
