{
  pkgs,
  flakePkgs,
  inputs,
  isDarwin,
  lib,
  ...
}: let
  # Link vi and vim to nvim
  neovim-unwrapped = flakePkgs.neovim.overrideAttrs (_: {
    postInstall = ''
      ln -s $out/bin/nvim $out/bin/vim
      ln -s $out/bin/nvim $out/bin/vi
    '';
  });

  # Nvim needs a lot of things in $PATH; don't install them globally just because of that.
  neovim-wrapped = pkgs.callPackage ./neovim.nix {
    inherit (flakePkgs) rust-analyzer;
    inherit neovim-unwrapped;

    # Copliot needs node v16 or v17 on M1, and v12-v17 on linux.
    nodejs = pkgs.nodejs-16_x;
  };

  neovimConfig = pkgs.callPackage ./config.nix {src = inputs.dotfiles;};
in {
  home.packages = [neovim-wrapped];

  home.file.".config/nvim".source = neovimConfig;
}
