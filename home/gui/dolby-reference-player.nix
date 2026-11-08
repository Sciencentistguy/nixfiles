{pkgs, ...}: let
  wine = pkgs.wineWow64Packages.stable;

  installer = pkgs.requireFile rec {
    name = "drp-ac4-windows-x64-3.2.0.msi";
    hash = "sha256-hQP3AFpS8/rMyX0SVvKbI3LpRZQxxwb3kXWd0wZ5DZo=";
    message = ''
      The Dolby Reference Player installer requires a Dolby developer login to download.
      Download ${name} and add it to the store with:
        nix-store --add-fixed sha256 ${name}
    '';
  };

  dolby-reference-player = pkgs.writeShellApplication {
    name = "dolby-reference-player";
    runtimeInputs = [wine];
    text = ''
      export WINEPREFIX="''${XDG_DATA_HOME:-$HOME/.local/share}/wineprefixes/dolby-reference-player"
      export WINEDEBUG=''${WINEDEBUG:--all}
      app="$WINEPREFIX/drive_c/Program Files/Dolby/Dolby Reference Player"

      mkdir -p "$WINEPREFIX"
      if [ ! -e "$app/drpv.exe" ]; then
        wine msiexec /i ${installer} /qn
      fi

      wine "$app/''${1:-drpv.exe}" "''${@:2}"
    '';
  };
in {
  home.packages = [dolby-reference-player];

  xdg.desktopEntries.dolby-reference-player = {
    name = "Dolby Reference Player";
    exec = "dolby-reference-player";
    categories = ["AudioVideo" "Player"];
  };
}
