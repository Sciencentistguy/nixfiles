{
  pkgs,
  flakePkgs,
  ...
}: {
  gtk = let
    dark-mode-selection = {
      gtk-application-prefer-dark-theme = 0;
    };
  in {
    enable = false;
    cursorTheme = {
      name = "MacOSMonterey";
      package = flakePkgs.apple-cursor-theme;
    };
    gtk3.extraConfig = dark-mode-selection;
    gtk4.extraConfig = dark-mode-selection;
  };
}
