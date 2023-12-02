{pkgs, ...}: {
  services.gitea = {
    enable = true;
    settings.server = {
      ROOT_URL = "https://git.quigley.xyz";
      HTTP_PORT = 3001;
      DOMAIN = "git.quigley.xyz";
    };
  };
}
