{ pkgs, ... }: {
  # TODO: flake this properly
  home.packages = with pkgs; [ shark-radar ];
}

