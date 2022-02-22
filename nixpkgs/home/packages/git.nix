{ pkgs, ... }:
{
  programs.git.enable = true;
  programs.git.delta.enable = true;
  programs.git.ignores = [
    "tags"
    ".vim/"
    ".ccls*/"
    ".clangd"
    ".DS_Store"
  ];
  programs.git.signing = {
    key = "30BBFF3FAB0BBB3E0435F83C8E8FF66E2AE8D970";
    signByDefault = true;
  };
  programs.git.userEmail = "jamie@quigley.xyz";
  programs.git.userName = "Jamie Quigley";
  programs.git.extraConfig = {
    init.defaultBranch = "master";
    pull.ff = "only";
  };

  programs.gh.enable = true;
  programs.gh.settings.git_protocol = "ssh";
}
