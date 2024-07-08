{
  pkgs,
  flakePkgs,
  ...
}: {
  home.packages = with pkgs; with flakePkgs; [rawtherapee adobe-dcp-camera-profiles];
}
