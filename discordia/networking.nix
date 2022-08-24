{pkgs, ...}: {
  networking.computerName = "discordia";
  networking.hostName = "discordia";

  environment.systemPackages = with pkgs; [tailscale];
}
