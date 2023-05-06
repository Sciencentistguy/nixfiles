{
  pkgs,
  flakePkgs,
  ...
}: {
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.desktopManager.gnome = {
    extraGSettingsOverridePackages = with pkgs; [gnome.gnome-settings-daemon];
    extraGSettingsOverrides = ''
      [org.gnome.settings-daemon.plugins.media-keys]
      custom-keybindings=['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']

      [org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom0]
      binding='<Super>Return'
      command='alacritty'
      name='Terminal'
    '';
  };

  services.gnome.gnome-browser-connector.enable = true;
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  environment.systemPackages = with pkgs; [
    flameshot
    gnome.gnome-tweaks

    materia-theme
    materia-kde-theme
    paper-icon-theme
    paper-gtk-theme
    flakePkgs.apple-cursor-theme

    gnomeExtensions.impatience
    (gnomeExtensions.hide-top-bar.overrideAttrs (old: {
      patches =
        old.patches
        or []
        ++ [ ./fix-gnome-44.patch
          # (fetchpatch {
            # url = "https://gitlab.gnome.org/tuxor1337/hidetopbar/-/commit/0e35d85c96e035c9ad8ee11133c56282bbba4192.diff";
            # sha256 = "sha256-2p9x2cG7tXjHggDTPgO613Bp6v45Ab6drz5S8QABA1o=";
          # })
        ];
    }))
    gnomeExtensions.custom-hot-corners-extended
  ];
}
