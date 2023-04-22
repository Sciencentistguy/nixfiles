{pkgs, ...}: {
  environment.systemPackages = with pkgs; [logiops];
}
