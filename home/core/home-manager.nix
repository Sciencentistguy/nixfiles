{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [inputs.home-manager.packages.${system}.home-manager];
}
