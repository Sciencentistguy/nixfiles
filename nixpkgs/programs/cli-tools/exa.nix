{ pkgs, isDarwin, ... }: {
  home.packages = with pkgs; [ exa ];
}
