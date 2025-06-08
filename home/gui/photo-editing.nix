{
  pkgs,
  flakePkgs,
  ...
}: {
  home.packages = [
    pkgs.bottles # for adobe dng converter
    flakePkgs.darktable

    flakePkgs.adobe-dcp-camera-profiles
    pkgs.rawtherapee
  ];
}
