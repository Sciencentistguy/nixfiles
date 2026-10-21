{
  pkgs,
  flakePkgs,
  ...
}: let
  # Nvim needs a lot of things in $PATH; don't install them globally just because of that.
  neovim-wrapped = pkgs.callPackage ./neovim.nix {
    inherit (pkgs) rust-analyzer;
    inherit (pkgs.neovim) rubyEnv;
    inherit (flakePkgs) nil;
    inherit (pkgs) neovim-unwrapped;
  };
in {
  home.packages = [neovim-wrapped];

  home.file.".config/nvim/lua/user".source = ./lua/user;
  home.file.".config/nvim/init.lua".source = ./init.lua;
}
