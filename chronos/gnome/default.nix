{
  pkgs,
  flakePkgs,
  lib,
  ...
}: {
  # mutter advertises fixed PQ defaults (10000 nits peak) for HDR outputs rather than the EDID's HDR luminance.
  # Patches 1-3 of https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/5068, plus the commits from main they're
  # based on and a fixup for 50.x. Patches 4-5 (Wine-specific protocol additions) conflict with 50.x and aren't
  # needed for this.
  nixpkgs.overlays = [
    (final: prev: {
      # !5068 targets main, so it can't land before 51; within 50.x a conflicting change fails the patch phase anyway
      mutter = assert lib.assertMsg (lib.versions.major prev.mutter.version == "50")
      "mutter is now ${prev.mutter.version}: check whether MR !5068 has landed or still applies, then update the patches in chronos/gnome/default.nix";
        prev.mutter.overrideAttrs (old: {
          patches =
            old.patches or []
            ++ map ({
              rev,
              hash,
            }:
              final.fetchpatch {
                url = "https://gitlab.gnome.org/GNOME/mutter/-/commit/${rev}.patch";
                inherit hash;
              }) [
              {
                # clutter/color-utils: Split out color utility types and functions
                rev = "4d918e456211dac6fc37fbec91c7da9494ea22ab";
                hash = "sha256-ce2AqMe/mhpCN9fva+wKQI0rce7ZryFFE0xj02z9UcM=";
              }
              {
                # wayland/color-management: Don't leak the preferred color state
                rev = "953764efc3f269058183e5147cb07d36ce83df77";
                hash = "sha256-HkHKbSqv+WiD/apXKjinBzCadKdKglmknwW0izilscg=";
              }
              {
                # color-management: Read EDID HDR metadata and complete the protocol
                rev = "7ea3b42384dcdae044c1e4d44b3563ef0cc47ab1";
                hash = "sha256-4dqAeYdJHfB48nrIOIKdL/4o6fiajrmn/5+0ihnxVqI=";
              }
              {
                # color-management: Tone map HDR content to detected display capabilities
                rev = "b52f757cd8d3bc0d647de432246fce8c0379c462";
                hash = "sha256-ECLnfkF2iYdwA3sJ5SZ8m0Jem78vZNMI9qjHisxIG00=";
              }
              {
                # color-management: Don't tone-map sources without mastering metadata
                rev = "d3999617798c967bbe751b15057223ebeb66580a";
                hash = "sha256-aWtK7Hl5ndl0dtvveHUvICjpYXId5jNy5uWjn5gSMng=";
              }
            ]
            # The MR predates eead94c54, which replaced meta_wayland_image_description_new_color_state
            ++ [./mutter-hdr-image-description-api.patch];
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
