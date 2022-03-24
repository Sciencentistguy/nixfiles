{ pkgs, ... }: {
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.desktopManager.gnome = {
    extraGSettingsOverridePackages = with pkgs; [ gnome.gnome-settings-daemon ];
    extraGSettingsOverrides = ''
      [org.gnome.settings-daemon.plugins.media-keys]
      custom-keybindings=['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']

      [org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom0]
      binding='<Super>Return'
      command='alacritty'
      name='Terminal'
    '';
  };

  environment.systemPackages =
    with pkgs; let
      macos-cursor-theme = pkgs.stdenv.mkDerivation {
        pname = "apple_cursor";
        version = "1.2.3";
        src = fetchTarball {
          url = "https://github.com/ful1e5/apple_cursor/releases/download/v1.2.3/macOSMonterey.tar.gz";
          sha256 = "081p1xaymc68yp8b84mnf6skbplsyxkr013wv7zfbba7rnvqpp7n";
        };

        dontConfigure = true;
        dontBuild = true;
        installPhase = ''
          mkdir -p $out/share/icons/macOSMonterey
          cp -a * $out/share/icons/macOSMonterey
        '';
      };
    in
    [
      gnome.gnome-tweaks
      materia-theme
      paper-icon-theme
      paper-gtk-theme
      macos-cursor-theme
    ];
}
