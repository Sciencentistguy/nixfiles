{
  pkgs,
  flakePkgs,
  ...
}: {
  home.packages = [
    pkgs.bottles # for adobe dng converter
    pkgs.darktable

    # flakePkgs.adobe-dcp-camera-profiles
    # pkgs.rawtherapee
  ];
}
