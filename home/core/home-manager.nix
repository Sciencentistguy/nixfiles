{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.home-manager];
}
