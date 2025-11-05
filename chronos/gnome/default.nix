{
  pkgs,
  flakePkgs,
  ...
}: {
  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.wayland = false;
  services.desktopManager.gnome.enable = true;
  services.desktopManager.gnome = {
    extraGSettingsOverridePackages = with pkgs; [gnome-settings-daemon];
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
    gnome-themes-extra
    flameshot
    gnome-tweaks

    paper-icon-theme
    paper-gtk-theme
    flakePkgs.apple-cursor-theme

    gnomeExtensions.blur-my-shell
    gnomeExtensions.custom-hot-corners-extended
    gnomeExtensions.impatience
    gnomeExtensions.just-perfection
  ];
}
