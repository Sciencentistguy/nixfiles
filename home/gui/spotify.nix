{pkgs, ...}: {
  home.packages = let
    # This is needed to fix external links being broken in spotify.
    # See: https://github.com/NixOS/nixpkgs/issues/47885
    spotify = pkgs.spotify.override {
      nss = pkgs.nss_latest;
    };
  in [spotify];
}
