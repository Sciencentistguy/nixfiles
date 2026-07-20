{pkgs, ...}: {
  home.packages = let
    spotify = pkgs.symlinkJoin {
      name = "spotify-wrapped";
      paths = [pkgs.spotify];
      nativeBuildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/spotify \
          --unset NIXOS_OZONE_WL
      '';
    };
  in [spotify];
}
