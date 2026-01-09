{pkgs, ...}: {
  home.packages = let
    spotify = pkgs.spotify.overrideAttrs (old: {
      # Under wayland spotify gains an ugly blue window border. Explicitly disable wayland in the
      # shell wrapper
      postFixup = ''
        sed -i '$i unset WAYLAND_DISPLAY' $out/share/spotify/spotify
      '';
    });
  in [spotify];
}
