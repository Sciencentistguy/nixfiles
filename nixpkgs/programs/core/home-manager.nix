{ pkgs, ... }: {
  home.packages = with pkgs; [ home-manager ];
}
