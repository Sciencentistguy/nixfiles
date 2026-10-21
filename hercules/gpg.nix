{pkgs, ...}: {
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.callPackage ../packages/pinentry-curses {};
    enableSSHSupport = true;
  };
  services.pcscd.enable = true;
}
