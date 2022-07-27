{pkgs, ...}: let
  open-sus-sh = pkgs.openssh.overrideAttrs (oldAttrs: {
    patches =
      oldAttrs.patches
      or []
      ++ [
        (pkgs.fetchpatch {
          url = "https://gist.githubusercontent.com/Sciencentistguy/18f94bde5ce06b63d760a736322b1aa0/raw/be75bcf34fe98fd49a68d2fccf366c5e51c06915/sussh.patch";
          sha256 = "sha256-PKrlujoTkvTDCl02AGR5vmlZVeSoLYZqQGERc1sI+hM";
        })
      ];
    dontCheck = true;
    checkTarget = [];
  });
in {
  home.packages = [open-sus-sh];

  programs.ssh.enable = true;
  programs.ssh.compression = false;

  programs.ssh.matchBlocks."github.com".identityFile = "~/.ssh/github";
  programs.ssh.matchBlocks."*.github.com".identityFile = "~/.ssh/github";
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
