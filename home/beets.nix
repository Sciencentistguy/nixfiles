{
  pkgs,
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
