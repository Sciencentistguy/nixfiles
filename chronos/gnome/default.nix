{
  pkgs,
  flakePkgs,
  lib,
  ...
}: {
  # mutter advertises fixed PQ defaults (10000 nits peak) for HDR outputs rather than the EDID's HDR luminance.
  # Patch 1 of https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/5068 rebased onto 51.x, plus the EDID luminance
  # fix from patch 2. The rest of patch 2 and patch 3 target the tone mapper that 51 removed; patches 4-5 are
  # Wine-specific protocol additions that aren't needed for this.
  nixpkgs.overlays = [
    (final: prev: {
      # The rebase is against 51.x; a newer major will need it redone or dropped if !5068 has landed
      mutter = assert lib.assertMsg (lib.versions.major prev.mutter.version == "51")
      "mutter is now ${prev.mutter.version}: check whether MR !5068 has landed or still applies, then update chronos/gnome/mutter-hdr-edid-luminance.patch";
        prev.mutter.overrideAttrs (old: {
          patches = old.patches or [] ++ [./mutter-hdr-edid-luminance.patch];
        });
    })
  ];

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
    # XWayland/FHS apps (e.g. Steam) don't see the GNOME cursor setting
    XCURSOR_THEME = "macOSMonterey";
    # NixOS default omits the system icon dir, where the cursor theme is installed
    XCURSOR_PATH = lib.mkForce "$HOME/.icons:$HOME/.local/share/icons:/run/current-system/sw/share/icons";
  };

  # Apps launched from the shell live in its cgroup; by default systemd stops
  # the whole unit (ending the session) when the kernel OOM-kills any of them.
  systemd.user.services."org.gnome.Shell@" = {
    overrideStrategy = "asDropin";
    serviceConfig.OOMPolicy = "continue";
    # the default service PATH would override the session's PATH for the shell and everything it launches
    path = lib.mkForce [];
  };

  services.gnome.gnome-browser-connector.enable = true;
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  environment.systemPackages = with pkgs; [
    gnome-themes-extra
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
