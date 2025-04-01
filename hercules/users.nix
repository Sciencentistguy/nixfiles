{pkgs, ...}: {
  users.users = {
    jamie = {
      uid = 1000;
      group = "jamie";
      shell = pkgs.zsh;
      extraGroups = ["wheel" "docker"];
      isNormalUser = true;
    };
    ncxl = {
      isSystemUser = true;
      uid = 100033;
      group = "nxcl";
    };
  };
  users.groups = {
    jamie = {
      gid = 1000;
    };
    nxcl = {gid = 100033;};
  };

  security.sudo.wheelNeedsPassword = false;

  fileSystems.scratch-area = {
    fsType = "tmpfs";
    device = "tmpfs";
    mountPoint = "/home/jamie/ScratchArea";
    options = ["size=16G"];
  };
}
