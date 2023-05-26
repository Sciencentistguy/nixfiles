{pkgs, ...}: let
  open-sus-sh = pkgs.openssh.overrideAttrs (oldAttrs: {
    patches = oldAttrs.patches or [] ++ [./sussh.patch];
    dontCheck = true;
    checkTarget = [];
  });
in {
  programs.ssh.enable = true;
  programs.ssh.package = open-sus-sh;
  programs.ssh.compression = false;

  programs.ssh.matchBlocks."github.com".identityFile = "~/.ssh/github";
  programs.ssh.matchBlocks."*.github.com".identityFile = "~/.ssh/github";
  programs.ssh.matchBlocks."git.quigley.xyz".identityFile = "~/.ssh/github";
  programs.ssh.matchBlocks."gitlab.com".identityFile = "~/.ssh/github";
  programs.ssh.matchBlocks."*.gitlab.com".identityFile = "~/.ssh/github";
  programs.ssh.matchBlocks."seedbox".identityFile = "~/.ssh/seedbox";
  programs.ssh.matchBlocks."seedbox".user = "sciencentistguy";
  programs.ssh.matchBlocks."aur.archlinux.org".identityFile = "~/.ssh/aur";
  programs.ssh.matchBlocks."ssh.york.ac.uk".user = "jehq500";
  programs.ssh.matchBlocks."rts001.cs.york.ac.uk" = {
    user = "jehq500";
    proxyCommand = "ssh -A -T -o Compression=no ssh.york.ac.uk -W %h:%p";
  };
}
