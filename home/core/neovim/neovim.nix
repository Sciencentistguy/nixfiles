{
  alejandra,
  clang-tools,
  curl,
  fd,
  fzf,
  git,
  gnumake,
  haskell-language-server,
  lib,
  lua-language-server,
  makeWrapper,
  neovim-unwrapped, # flake
  nil, # flake
  nodejs,
  ormolu,
  perl,
  pyright,
  python3,
  ripgrep,
  rust-analyzer, # flake
  rubyPackages,
  rustfmt,
  shellcheck,
  shfmt,
  stdenv,
  stylua,
  symlinkJoin,
  tree-sitter,
  xclip,
  zathura,
  prettier,
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
        prettier
        shfmt
        rustfmt
        ormolu

        # Language servers
        rust-analyzer
        lua-language-server
        pyright
        nil
        haskell-language-server
        clang-tools
        rubyPackages.solargraph
      ]
      ++ lib.optionals (!stdenv.hostPlatform.isDarwin) [
        xclip
      ];
  in ''
    wrapProgram $out/bin/nvim \
      --prefix PATH : ${lib.makeBinPath path} \
      --prefix LD_LIBRARY_PATH : ${stdenv.cc.cc.lib}/lib
  '';
}
