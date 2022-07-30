{pkgs, ...}: {
  services.gitea = {
    enable = true;
    httpPort = 3001;
    domain = "git.quigley.xyz";
    rootUrl = "https://git.quigley.xyz";
    # settings = {
      # server.ROOT_URL = "";
    # };
  };
}
