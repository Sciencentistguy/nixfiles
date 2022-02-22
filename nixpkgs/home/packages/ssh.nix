{ pkgs, ... }:
{
  programs.ssh.enable = true;
  programs.ssh.compression = true;

  programs.ssh.matchBlocks."github.com".identityFile = "~/.ssh/github";
  programs.ssh.matchBlocks."*.github.com".identityFile = "~/.ssh/github";
  programs.ssh.matchBlocks."gitlab.com".identityFile = "~/.ssh/github";
  programs.ssh.matchBlocks."*.gitlab.com".identityFile = "~/.ssh/github";
  programs.ssh.matchBlocks."seedbox".identityFile = "~/.ssh/seedbox";
  programs.ssh.matchBlocks."seedbox".user = "sciencentistguy";
  programs.ssh.matchBlocks."aur.archlinux.org".identityFile = "~/.ssh/aur";
  programs.ssh.matchBlocks."*.york.ac.uk".user = "jehq500";
}
