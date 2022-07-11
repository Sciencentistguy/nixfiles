{pkgs, ...}: {
  homebrew.enable = true;
  homebrew.autoUpdate = true;
  homebrew.cleanup = "zap";
  homebrew.global.brewfile = true;
  homebrew.global.noLock = true;

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
    Slack = 803453959;
    Bitwarden = 1352778147;
    Tailscale = 1475387142;
  };

  homebrew.casks = [
    "discord-canary"
    "drawio"
    "firefox"
    "flameshot"
    "ghidra"
    "gimp"
    "gitkraken"
    "google-chrome"
    "google-drive"
    "intellij-idea-ce"
    "iterm2"
    "keybase"
    "logitech-options"
    "mullvadvpn"
    "multimc"
    "plexamp"
    "qbittorrent"
    "rectangle"
    "sonos"
    "spotify"
    "steam"
    "temurin"
    "temurin8"
    "utm"
    "visual-studio-code"
    "vlc"
  ];

  homebrew.brews = [
    "llvm@13"
  ];
}
