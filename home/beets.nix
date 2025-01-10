{
  pkgs,
  flakePkgs,
  ...
}: {
  programs.beets.enable = true;
  programs.beets.package = pkgs.beets-unstable; # TODO: reinstate beets-file-info at some point

  programs.beets.settings = {
    directory = "/storage-pool/media/Music";
    plugins = [
      "badfiles"
      "chroma"
      "duplicates"
      "edit"
      "embedart"
      "fetchart"
      # "fileinfo"
      "fromfilename"
      "mbsubmit"
      "mbsync"
      "missing"
      "scrub"
      "rewrite"
    ];
    # Ideally this would be set, but if the only art that exists is <1000, I still want to fetch
    # it.
    # fetchart.minwidth = 1000;
    fetchart.sources = [
      "filesystem"
      {coverart = "release";}
      {coverart = "releasegroup";}
    ];
    import.timid = true;
    rewrite = {
      "artist r u s s e l b u c k" = "russelbuck";
    };
  };
}
