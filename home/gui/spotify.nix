{pkgs, ...}: {
  home.packages = let
    # Horrible hack - see https://github.com/NixOS/nixpkgs/issues/227449
    spotify = pkgs.spotify.override {
      callPackage = p: attrs: pkgs.callPackage p (attrs // {nss = pkgs.nss_latest;});
    };
  in [spotify];
}
