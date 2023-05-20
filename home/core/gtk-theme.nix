{
  pkgs,
  flakePkgs,
  ...
}: {
  gtk = {
    enable = true;
    cursorTheme.package = flakePkgs.apple-cursor-theme;
    cursorTheme.name = "MacOSMonterey";
  };
}
