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

    matchBlocks = {
      "*" = {
        compression = false;
      };

      "github.com".identityFile = "~/.ssh/github";
      "*.github.com".identityFile = "~/.ssh/github";
      "git.quigley.xyz".identityFile = "~/.ssh/github";
      "gitlab.com".identityFile = "~/.ssh/github";
      "*.gitlab.com".identityFile = "~/.ssh/github";
      "ssh.york.ac.uk".user = "jehq500";
      "rts001.cs.york.ac.uk" = {
        user = "jehq500";
        proxyCommand = "ssh -A -T -o Compression=no ssh.york.ac.uk -W %h:%p";
      };
    };
  };
}
