{
  buildFHSEnv,
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
}:
buildFHSEnv {
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
}
