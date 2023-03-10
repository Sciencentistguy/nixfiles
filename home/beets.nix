{
  pkgs,
  lib,
  flakePkgs,
  ...
}: let
  beets = pkgs.beets.overrideAttrs (oldAttrs: {
    propagatedBuildInputs =
      (oldAttrs.propagatedBuildInputs or [])
      ++ [
        flakePkgs.beets-file-info
        pkgs.python3Packages.pillow
      ];
    src = pkgs.fetchFromGitHub {
      owner = "beetbox";
      repo = "beets";
      rev = "1f9113af73b84c202ab4ae699406ee8d4fba5158";
      sha256 = "sha256-D/HlJtsf55V67GjP8YLyqlXvoo5lpUsuQNx6zC+enbg=";
    };
    version = assert lib.versionAtLeast "1.6.0" oldAttrs.version; "unstable-2023-03-08";
    patches = lib.init oldAttrs.patches;
    dontCheck = true;
    doInstallCheck = false;
  });
in {
  programs.beets.enable = true;
  programs.beets.package = beets;
  programs.beets.settings = {
    directory = "~/Music/beets";
    plugins = [
      "acousticbrainz"
      "badfiles"
      "chroma"
      "duplicates"
      "edit"
      "embedart"
      "fetchart"
      "fileinfo"
      "fromfilename"
      "mbsubmit"
      "mbsync"
      "missing"
      "scrub"
    ];
    fetchart.minwidth = 1000;
    import.timid = true;
  };
}
