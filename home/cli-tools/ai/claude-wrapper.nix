{
  claude-code,
  curl,
  fd,
  jq,
  lib,
  makeWrapper,
  nodejs,
  perl,
  python3,
  ripgrep,
  ruby,
  symlinkJoin,
  tree,
  unzip,
}: let
  runtimeTools = [
    curl
    fd
    jq
    nodejs
    perl
    python3
    ripgrep
    ruby
    tree
    unzip
  ];
in
  symlinkJoin {
    inherit (claude-code) name version meta;
    paths = [claude-code];
    nativeBuildInputs = [makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/claude \
        --prefix PATH : ${lib.makeBinPath runtimeTools} \
        --set BUN_OPTIONS "--preload=${./no-agent-summary.js}"
    '';
  }
