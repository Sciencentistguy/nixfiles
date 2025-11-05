{
  pkgs,
  home-manager,
  isDarwin,
  ...
}: {
  programs.git = {
    enable = true;
    ignores = [
      "tags"
      ".vim/"
      ".ccls*/"
      ".clangd"
      ".DS_Store"
    ];
    signing = {
      key = "30BBFF3FAB0BBB3E0435F83C8E8FF66E2AE8D970";
      signByDefault = true;
    };
    settings = {
      user = {
        email = "jamie@quigley.xyz";
        name = "Jamie Quigley";
      };
      init.defaultBranch = "master";
      pull.ff = "only";
      url."https://github.com/".insteadOf = "git://github.com/";
      push.autoSetupRemote = true;
    };
  };

  programs.difftastic = {
    enable = true;
    git.enable = true;
  };

  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };

  home.packages = with pkgs; [gitui];
}
