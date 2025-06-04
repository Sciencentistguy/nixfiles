{
  pkgs,
  flakePkgs,
  ...
}: {
  home.packages = with pkgs;
  with flakePkgs; [
    adobe-dcp-camera-profiles
    darktable
    rawtherapee
  ];
}
