{pkgs, ...}: {
  services.hardware.openrgb.enable = true;
  services.hardware.openrgb.motherboard = "intel";
}
