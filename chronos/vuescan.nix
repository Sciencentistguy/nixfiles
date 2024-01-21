{flakePkgs, ...}: {
  services.udev.packages = [flakePkgs.vuescan-unwrapped];
  environment.systemPackages = [flakePkgs.vuescan];
}
