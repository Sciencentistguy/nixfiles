{pkgs, ...}: {
  programs.steam.enable = true;
  environment.systemPackages = [
    (pkgs.heroic.override {
      extraPkgs = pkgs: [
        pkgs.gamescope
        pkgs.gamemode
      ];
    })
  ];
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
}
