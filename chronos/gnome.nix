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

  services.gnome.chrome-gnome-shell.enable = true;
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
    gnomeExtensions.hide-top-bar
    gnomeExtensions.custom-hot-corners-extended
    gnomeExtensions.clear-top-bar
  ];
}
