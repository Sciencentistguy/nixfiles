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
    # Pull an unstable beets version to get the fix for https://github.com/beetbox/beets/issues/4528
    version = assert lib.versionAtLeast "1.6.0" oldAttrs.version; "unstable-2023-03-08";
    patches =
      # Drop the last patch, as it is for an older version
      lib.init oldAttrs.patches
      ++ [
        (pkgs.fetchpatch {
          # Replace the test 'remove' with 'replace' in the beets CLI
          url = "https://github.com/Sciencentistguy/beets/commit/771a3e2af219e5e7a9d2819904f8d0ba1d739d90.patch";
          sha256 = "sha256-PsnmIarjDb8FklgOz9DI5ORplidMM7yD11FufeNZK5c=";
        })
      ];
    dontCheck = true;
    doInstallCheck = false;
  });
in {
  programs.beets.enable = true;
  programs.beets.package = beets;
  programs.beets.settings = {
    directory = "~/Music/beets";
    plugins = [
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
    # Ideally this would be higher, but if the only art that exists is <1000, I still want to
    # fetch it.
    fetchart.minwidth = 500;
    fetchart.sources = [
      "filesystem"
      {coverart = "release";}
      {coverart = "releasegroup";}
    ];
    import.timid = true;
  };
}
