{pkgs, ...}: {
  programs.claude-code = {
    enable = true;
    package = pkgs.callPackage ./claude-wrapper.nix {};
    context = ./CLAUDE.md;
    mutableSettings = true;
    settings = {
      showThinkingSummaries = true;
      theme = "auto";
      env = {
        "GIT_CONFIG_COUNT" = "1";
        "GIT_CONFIG_KEY_0" = "user.signingkey";
        "GIT_CONFIG_VALUE_0" = "688D322814AF66F4707E7D3A61DED248F873842E";
      };
    };
  };
}
