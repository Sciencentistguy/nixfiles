{
  lib,
  pkgs,
  flakePkgs,
  ...
}: {
  home.packages = assert lib.versionOlder pkgs.spotify.version flakePkgs.spotify.version; [flakePkgs.spotify];
}
