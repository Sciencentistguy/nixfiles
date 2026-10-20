{pkgs, ...}: let
  open-sus-sh = pkgs.openssh.overrideAttrs (oldAttrs: {
    patches = oldAttrs.patches or [] ++ [./sussh.patch];
    dontCheck = true;
    checkTarget = [];
  });
in {
  programs.ssh = {
    enable = true;
    package = open-sus-sh;
    enableDefaultConfig = false;

    settings = {
      "*".Compression = false;

      "github.com".IdentityFile = "~/.ssh/github";
      "*.github.com".IdentityFile = "~/.ssh/github";
      "git.quigley.xyz".IdentityFile = "~/.ssh/github";
      "gitlab.com".IdentityFile = "~/.ssh/github";
      "*.gitlab.com".IdentityFile = "~/.ssh/github";
      "ssh.york.ac.uk".User = "jehq500";
      "rts001.cs.york.ac.uk" = {
        User = "jehq500";
        ProxyCommand = "ssh -A -T -o Compression=no ssh.york.ac.uk -W %h:%p";
      };
    };
  };
}
