{pkgs, ...}: {
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
    enableSSHSupport = true;
  };
  services.pcscd.enable = true;
}
