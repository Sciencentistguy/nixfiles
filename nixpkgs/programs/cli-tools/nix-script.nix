{ pkgs, ... }: {
  home.packages = with pkgs; [ nix-script nix-script-haskell ];
}
