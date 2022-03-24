{ pkgs, ... }: {
  i18n.defaultLocale = "en_GB.UTF-8";
  console. useXkbConfig = true; # use xkbOptions in tty.

  # Configure keymap in X11
  services.xserver.layout = "gb";
  services.xserver.xkbOptions = "caps:escape"; # map caps to escape.
}
