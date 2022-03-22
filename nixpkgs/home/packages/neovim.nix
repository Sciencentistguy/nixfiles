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

    # Runtimes
    (pkgs.python3.withPackages (pythonPackages: with pythonPackages; [ pynvim ]))
    pkgs.nodejs

    # Linters
    pkgs.shellcheck

    # Formatters
    pkgs.python3Packages.autopep8
    pkgs.python3Packages.black
    pkgs.shfmt
    pkgs.stylua
    pkgs.nixpkgs-fmt
    pkgs.nodePackages.prettier

    # Language servers
    pkgs.rust-analyzer-nightly
    pkgs.sumneko-lua-language-server
    pkgs.nodePackages.pyright
    pkgs.rnix-lsp
  ];
}
