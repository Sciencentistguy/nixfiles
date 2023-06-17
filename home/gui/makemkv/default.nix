{pkgs, ...}: {
  home.packages = let
    makemkv = pkgs.libsForQt5.callPackage ./makemkv.nix {
            # inherit (pkgs.stdenv) mkDerivation;
            # inherit (pkgs.qt6) qtbase;
        };
  in [makemkv];
}
