{
  pkgs,
  flakePkgs,
  ...
}: let
  # Link vi and vim to nvim
  neovim-unwrapped = pkgs.neovim-unwrapped.overrideAttrs (_: {
    postInstall = ''
      ln -s $out/bin/nvim $out/bin/vim
      ln -s $out/bin/nvim $out/bin/vi
    '';
  });

  # Nvim needs a lot of things in $PATH; don't install them globally just because of that.
  neovim-wrapped = pkgs.callPackage ./neovim.nix {
    inherit (pkgs) rust-analyzer;
    inherit (flakePkgs) nil;
    inherit neovim-unwrapped;
  };
in {
  home.packages = [neovim-wrapped];

  home.file.".config/nvim/lua/user".source = ./lua/user;
  home.file.".config/nvim/init.lua".source = ./init.lua;
}
