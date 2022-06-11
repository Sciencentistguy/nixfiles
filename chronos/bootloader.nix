{pkgs, ...}: {
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.secureboot = {
    enable = true;
    signingKeyPath = "/secureboot/DB.key";
    signingCertPath = "/secureboot/DB.crt";
  };
}
