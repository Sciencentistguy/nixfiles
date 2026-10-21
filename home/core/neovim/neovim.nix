{
  alejandra,
  clang-tools,
  curl,
  fd,
  git,
  gnumake,
  haskell-language-server,
  lib,
  lua-language-server,
  makeWrapper,
  neovim-unwrapped, # flake
  neovim-node-client,
  nil, # flake
  ormolu,
  perl,
  python3,
  ripgrep,
  ruff,
  rust-analyzer,
  rustfmt,
  shellcheck,
  shfmt,
  stdenv,
  stylua,
  symlinkJoin,
  tree-sitter,
  wl-clipboard,
  ty,
  xclip,
  prettier,
}:
symlinkJoin {
  name = "neovim";
  paths = [neovim-unwrapped];
  buildInputs = [makeWrapper];
  postBuild = let
    python = python3.withPackages (pp: with pp; [pynvim]);
    perlEnv = perl.withPackages (pp: with pp; [NeovimExt MsgPackRaw]);
    # Same host_prog setup that nixpkgs's neovim wrapper generates
    providers = lib.concatStringsSep ";" [
      "vim.g.python3_host_prog=[[${python}/bin/python3]]"
      "vim.g.node_host_prog=[[${neovim-node-client}/bin/neovim-node-host]]"
      "vim.g.perl_host_prog=[[${perlEnv}/bin/perl]]"
    ];
    path =
      [
        curl
        fd
        git
        ripgrep
        stdenv.cc
        tree-sitter
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
        ruff

        # Language servers
        rust-analyzer
        lua-language-server
        ty
        nil
        haskell-language-server
        clang-tools
      ]
      ++ lib.optionals (!stdenv.hostPlatform.isDarwin) [
        wl-clipboard
        xclip
      ];
  in ''
    wrapProgram $out/bin/nvim \
      --suffix PATH : ${lib.makeBinPath path} \
      --add-flags '--cmd "lua ${providers}"'

    # Link vi and vim to the wrapped nvim
    ln -s nvim $out/bin/vim
    ln -s nvim $out/bin/vi
  '';
}
