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
  home.packages = [
    neovim

    # Dependencies
    (pkgs.python3.withPackages (pythonPackages: with pythonPackages; [ pynvim ]))
    pkgs.nodejs
    pkgs.yarn

    # Linters
    pkgs.shellcheck

    # Formatters
    pkgs.python3Packages.autopep8
    pkgs.python3Packages.black
    pkgs.shfmt
    pkgs.stylua
    pkgs.nixpkgs-fmt

    # Language servers
    pkgs.rust-analyzer-nightly
    pkgs.sumneko-lua-language-server
  ];
}
