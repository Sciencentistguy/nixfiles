{...}: {
  i18n.defaultLocale = "en_GB.UTF-8";
  console.useXkbConfig = true; # use xkbOptions in tty.

  # Configure keymap in X11
  services.xserver.xkb.layout = "gb";
  services.xserver.xkb.options = "caps:escape"; # map caps to escape.
}
