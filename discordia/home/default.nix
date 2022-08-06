{
  pkgs,
  home-manager,
  ...
}: {
  # `home-manager` config
  home-manager.extraSpecialArgs = specialArgs;
  home-manager.useGlobalPkgs = true;

  home-manager.users.jamie = {
    home.stateVersion = homeManagerStateVersion;
    imports = [
      ./home/core
      ./home/cli-tools
      ./home/dev

      ./home/gui/alacritty
    ];
  };

  home-manager.users.root = {
    home.stateVersion = homeManagerStateVersion;
    imports = [
      ./discordia/root
    ];
  };
}
