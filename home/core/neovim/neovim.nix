{
  alejandra,
  curl,
  fd,
  fzf,
  git,
  gnumake,
  lib,
  makeWrapper,
  neovim-unwrapped, # flake
  nil, # flake
  nodePackages,
  nodejs,
  perl,
  pyright,
  python3,
  ripgrep,
  rust-analyzer, # flake
  rustfmt,
  shellcheck,
  shfmt,
  stdenv,
  stylua,
  sumneko-lua-language-server,
  symlinkJoin,
  tree-sitter,
  xclip,
  zathura,
}:
symlinkJoin {
  name = "neovim";
  paths = [neovim-unwrapped];
  buildInputs = [makeWrapper];
  postBuild = let
    python = python3.withPackages (pp: with pp; [pynvim black]);
    path =
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
        gnumake

        # Linters
        shellcheck

        # Formatters
        stylua
        alejandra
        nodePackages.prettier
        shfmt
        rustfmt

        # Language servers
        rust-analyzer
        sumneko-lua-language-server
        pyright
        nil
      ]
      ++ lib.optionals (!stdenv.isDarwin) [
        xclip
      ];
  in ''
    wrapProgram $out/bin/nvim\
      --prefix PATH : ${lib.makeBinPath path} \
      --set LD_LIBRARY_PATH ${stdenv.cc.cc.lib}/lib
  '';
}
