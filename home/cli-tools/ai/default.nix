{pkgs, ...}: let
  runtimeTools = with pkgs; [
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
  claude-code = pkgs.symlinkJoin {
    inherit (pkgs.claude-code) name version meta;
    paths = [pkgs.claude-code];
    nativeBuildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/claude --prefix PATH : ${pkgs.lib.makeBinPath runtimeTools}
    '';
  };
in {
  programs.claude-code = {
    enable = true;
    package = claude-code;
    context = ./CLAUDE.md;
    mutableSettings = true;
    settings = {
      theme = "auto";
      env = {
        "GIT_CONFIG_COUNT" = "1";
        "GIT_CONFIG_KEY_0" = "user.signingkey";
        "GIT_CONFIG_VALUE_0" = "688D322814AF66F4707E7D3A61DED248F873842E";
      };
    };
  };
}
