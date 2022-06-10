{
  pkgs,
  lib,
  isDarwin,
  ...
}: let
  # build neovim nightly rather than the most recent release in nixpkgs
  # also link vi and vim to nvim
  neovim = pkgs.neovim-nightly.overrideAttrs (old: {
    postInstall = ''
      ln -s $out/bin/nvim $out/bin/vim
      ln -s $out/bin/nvim $out/bin/vi
    '';
  });
in {
  home.packages =
    [
      neovim

      # Runtimes
      (pkgs.python3.withPackages (pythonPackages: with pythonPackages; [pynvim]))
      pkgs.nodejs

      # Linters
      pkgs.shellcheck

      # Formatters
      pkgs.shfmt
      pkgs.stylua
      pkgs.alejandra
      pkgs.nodePackages.prettier

      # Language servers
      # Pin rust-analyzer. See https://github.com/rust-lang/rust-analyzer/issues/12482
      # pkgs.rust-analyzer-nightly
      (
        pkgs.fenix.toolchainOf {
          channel = "nightly";
          date = "2022-05-30";
          sha256 = "sha256-N9V9NJ3BDUC81tIbYxAXQemrhR1l9jLd5t9L70NfcZo=";
        }
      )
      .rust-analyzer-preview
      pkgs.sumneko-lua-language-server
      pkgs.nodePackages.pyright
      pkgs.rnix-lsp

      # Utilities
      pkgs.fzf
    ]
    ++ lib.optionals (!isDarwin) [
      pkgs.xclip
      pkgs.python3Packages.black
    ];
}
