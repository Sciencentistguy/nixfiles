{ pkgs, nixpkgsConfig, ... }: {
  nixpkgs = nixpkgsConfig;
  nix.extraOptions = ''
    experimental-features = flakes nix-command
  '';
}
