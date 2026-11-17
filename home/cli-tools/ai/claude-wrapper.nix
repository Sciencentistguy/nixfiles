{
  claude-code,
  lib,
  makeWrapper,
  pkgs,
  symlinkJoin,
}:
symlinkJoin {
  inherit (claude-code) name version meta;
  paths = [claude-code];
  nativeBuildInputs = [makeWrapper];
  postBuild = ''
    wrapProgram $out/bin/claude \
      --prefix PATH : ${lib.makeBinPath (import ./runtime-tools.nix pkgs)}
  '';
}
