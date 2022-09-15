{
  pkgs,
  flakePkgs,
  ...
}: {
  home.packages = with flakePkgs; [
    extract
    search-edit
    update-music-library
  ];
}
