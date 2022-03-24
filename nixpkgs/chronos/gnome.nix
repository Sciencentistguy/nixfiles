{ pkgs, ... }: {
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];


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

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    materia-theme
    paper-icon-theme
    paper-gtk-theme
  ];
}
