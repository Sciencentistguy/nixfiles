{ pkgs, ... }:
let
  # build neovim nightly rather than the most recent release in nixpkgs
  # also link vi and vim to nvim
  neovim = pkgs.neovim-nightly.overrideAttrs (old: {
    postInstall = ''
      ln -s $out/bin/nvim $out/bin/vim
      ln -s $out/bin/nvim $out/bin/vi
    '';
  });
in
{
  home.packages =
    [
      neovim

      (pkgs.python3.withPackages (pythonPackages: with pythonPackages; [ pynvim ]))
      pkgs.nodejs
      pkgs.python3Packages.autopep8
      pkgs.shellcheck
      pkgs.shfmt
      pkgs.stylua
      pkgs.yarn
    ];
}
