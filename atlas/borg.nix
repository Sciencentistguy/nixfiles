{
  pkgs,
  homeManagerStateVersion,
  ...
}: {
  users = {
    groups.borg = {};
    users.borg = {
      isSystemUser = true;
      group = "borg";
      home = "/storage-pool/borg";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHVfP8wWqsRqiBpdsIA1EJYzqblfz2i9X8wcEzNiQMGY jamie@hercules"
      ];
      shell = pkgs.zsh;
    };
  };

  home-manager.users.borg = {
    home.stateVersion = homeManagerStateVersion;
    programs.atuin = {
      enable = true;
      enableZshIntegration = true;
      flags = ["--disable-up-arrow"];
    };
    programs.starship.enable = true;
    home.packages = with pkgs; [rclone];
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
    };
  };
}
