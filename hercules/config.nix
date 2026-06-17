{pkgs, ...}: {
  virtualisation.docker.enable = true;
  # services.vscode-server.enable = true;

  systemd.services.lxc-activation-fix = {
    description = "NixOS LXC Runtime Activation Fix";
    after = ["systemd-tmpfiles-setup.service"];
    before = ["sysinit.target"];
    wantedBy = ["sysinit.target"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "/nix/var/nix/profiles/system/activate";
    };
  };

  systemd.tmpfiles.rules = [
    "L+ /run/current-system - - - - /nix/var/nix/profiles/system"
  ];
}
