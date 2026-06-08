{
  lib,
  symlinkJoin,
  buildFHSEnv,
  makeDesktopItem,
  vuescan-unwrapped,
  udev,
  alsa-lib,
  gtk2,
  gtk3,
  gtk4,
  gdk-pixbuf,
  cairo,
  pango,
  fontconfig,
  glib,
  freetype,
  libuuid,
  zlib,
  libX11,
  libXcursor,
  libXrandr,
  libSM,
}: let
  fhsEnv = buildFHSEnv {
    name = "vuescan";
    targetPkgs = pkgs: [
      vuescan-unwrapped
      udev
      alsa-lib
      gtk2
      gtk3
      gtk4
      gdk-pixbuf
      cairo
      pango
      fontconfig
      glib
      freetype
      libuuid
      zlib
      libX11
      libXcursor
      libXrandr
      libSM
    ];
    runScript = "vuescan";
  };

  vuescan-desktop = makeDesktopItem {
    name = "vuescan";
    exec = "vuescan";
    icon = "vuescan";
    desktopName = "VueScan";
    genericName = "Scanning Software";
    comment = "Scan documents and photos";
    categories = ["Graphics" "Scanning"];
    terminal = false;
  };
in
  symlinkJoin {
    pname = "vuescan";
    version = "1.0";

    phases = ["installPhase"];

    paths = [
      fhsEnv
      vuescan-desktop
    ];
    # installPhase = ''
    # mkdir -p $out/bin
    # mkdir -p $out/share/applications
    # ln -s ${fhsEnv}/bin/vuescan $out/bin/vuescan
    # cp ${vuescan-desktop}/share/applications/* $out/share/applications/
    # '';

    meta = with lib; {
      description = "VueScan with GNOME Desktop integration";
      platforms = platforms.linux;
    };
  }
