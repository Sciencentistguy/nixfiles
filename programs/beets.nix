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
    # acoustid.apikey = builtins.readfile config.age.secrets.secret1.path;
    fetchart.minwidth = 1000;
    import.timid = true;
  };
}
