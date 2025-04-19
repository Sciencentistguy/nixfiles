{pkgs, ...}: {
  users = {
    groups.borg = {};
    users.borg = {
      isSystemUser = true;
      group = "borg";
      home = "/storage-pool/borg";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHVfP8wWqsRqiBpdsIA1EJYzqblfz2i9X8wcEzNiQMGY jamie@hercules"
      ];
      shell = pkgs.bashInteractive;
    };
  };
}
