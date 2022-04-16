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

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

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
      materia-kde-theme
      paper-icon-theme
      paper-gtk-theme
      macos-cursor-theme
      flameshot

      gnomeExtensions.impatience
      gnomeExtensions.hide-top-bar
      (with pkgs; stdenv.mkDerivation {
        pname = "gnome-shell-extension-clear-top-bar-unstable";
        version = "2022-04-16";
        src = fetchFromGitHub {
          owner = "Sciencentistguy"; # remove when PR merges
          repo = "gnome-shell-extension-clear-top-bar";
          rev = "5623807b50331ed6efe6a86f43bbe1018a854907";
          sha256 = "sha256-rggFQiyag2PbaiXa48TUFhlbknKLICWxJuKFXJdbUPk=";
        };
        installPhase = ''
          mkdir -p $out/share/gnome-shell/extensions
          cp -a src $out/share/gnome-shell/extensions/clear-top-bar@superterran.net
        '';
      })
    ];
}
