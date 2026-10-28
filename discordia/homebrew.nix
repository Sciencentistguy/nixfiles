{pkgs, ...}: {
  homebrew.enable = true;
  homebrew.onActivation.autoUpdate = true;
  homebrew.onActivation.upgrade = true;
  homebrew.global.brewfile = true;

  homebrew.taps = [
    "homebrew/cask"
    "homebrew/cask-drivers"
    "homebrew/cask-fonts"
    "homebrew/cask-versions"
    "homebrew/core"
    "homebrew/services"
    "nrlquaker/createzap"
  ];

  homebrew.masApps = {
    Keynote = 409183694;
    Numbers = 409203825;
    Pages = 409201541;
    Bitwarden = 1352778147;
    Tailscale = 1475387142;
    WhatsApp = 310633997;
    "Windows App" = 1295203466;
  };

  homebrew.casks = [
    "audacity"
    "discord"
    "disk-inventory-x"
    "drawio"
    "firefox"
    "gitkraken"
    "google-chrome"
    "google-drive"
    "iterm2"
    "makemkv"
    "musicbrainz-picard"
    "plexamp"
    "prismlauncher"
    "qbittorrent"
    "rectangle"
    "sonos"
    "spotify"
    "steam"
    "syncthing-app"
    "utm"
    "visual-studio-code"
    "vlc"
    "warp"
    "zulu"
    "zulu@17"
    "zulu@8"
  ];
}
