{
  alacritty,
  fetchFromGitHub,
  lib,
}:
alacritty.overrideAttrs (old: rec {
  version = assert !lib.versionOlder "0.10.1" old.version; "unstable-2022-07-15";
  src = fetchFromGitHub {
    owner = old.pname;
    repo = old.pname;
    rev = "2a676dfad837d1784ed0911d314bc263804ef4ef";
    sha256 = "sha256-Qb53jPSpN/vnUkqZTUL3g5QGWR/5VtVexLnS8Mm8ZZk=";
  };

  cargoDeps = old.cargoDeps.overrideAttrs (_: {
    inherit src;
    outputHash = "sha256-Lw2X59nBIk7Y+OrDINOT9bXQNqouYlX64xseNzzfO6g=";
  });
  patches =
    (old.patches or [])
    ++ [
      ./stfu-alacritty.patch
    ];
})
