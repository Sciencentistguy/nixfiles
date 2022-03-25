{ pkgs, ... }: {
  home.packages = with pkgs; [ killall ];
}
