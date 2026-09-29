{
  pkgs,
  flakePkgs,
  lib,
  ...
}: {
  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
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

  # Ensure dconf is enabled
  programs.dconf.enable = true;

  # Override GDM's default dconf settings
  programs.dconf.profiles.gdm.databases = [
    {
      settings = {
        "org/gnome/desktop/session" = {
          # Disable screen blanking
          idle-delay = lib.gvariant.mkUint32 0;
        };
        "org/gnome/settings-daemon/plugins/power" = {
          # Disable automatic suspend on AC and Battery
          sleep-inactive-ac-timeout = lib.gvariant.mkInt32 0;
          sleep-inactive-ac-type = "nothing";
          sleep-inactive-battery-timeout = lib.gvariant.mkInt32 0;
          sleep-inactive-battery-type = "nothing";
        };
      };
    }
  ];

  environment.variables = {
    WAYLAND_DISPLAY = "wayland-0"; # Explicitly set if GNOME fails to export it
    NIXOS_OZONE_WL = "1"; # Helps many other apps (Electron/Chromium) use Wayland
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
    flakePkgs.apple-cursor-theme

    gnomeExtensions.blur-my-shell
    gnomeExtensions.custom-hot-corners-extended
    gnomeExtensions.impatience
    gnomeExtensions.just-perfection
    gnomeExtensions.unblank
  ];
}
