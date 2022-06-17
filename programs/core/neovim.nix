{
  pkgs,
  lib,
  isDarwin,
  ...
}: let
  # build neovim nightly rather than the most recent release in nixpkgs
  # also link vi and vim to nvim
  neovim' = pkgs.neovim-nightly.overrideAttrs (old: {
    postInstall = ''
      ln -s $out/bin/nvim $out/bin/vim
      ln -s $out/bin/nvim $out/bin/vi
    '';
  });

  # Nvim needs things from path; don't install them globally just because of that.
  neovim = pkgs.symlinkJoin {
    name = "neovim";
    paths = [neovim'];
    buildInputs = [pkgs.makeWrapper];
    postBuild = let
      python = pkgs.python3.withPackages (pp: with pp; [pynvim black]);
    in ''
      wrapProgram $out/bin/nvim\
        --prefix PATH : ${lib.makeBinPath (with pkgs;
        [
          curl
          fd
          fzf
          git
          nodejs
          perl
          python
          ripgrep
          stdenv.cc
          tree-sitter
          zathura
        ]
        ++ lib.optionals (!isDarwin) [
          pkgs.xclip
        ])}
    '';
  };
in {
  home.packages = [
    neovim

    # Linters
    pkgs.shellcheck

    # Formatters
    pkgs.shfmt
    pkgs.stylua
    pkgs.alejandra
    pkgs.nodePackages.prettier

    # Language servers
    pkgs.rust-analyzer-nightly
    pkgs.sumneko-lua-language-server
    pkgs.nodePackages.pyright
    pkgs.rnix-lsp
  ];
}
