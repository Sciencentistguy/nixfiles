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
  nodejs,
  ormolu,
  perl,
  pyright,
  python3,
  ripgrep,
  rubyPackages,
  rust-analyzer,
  rubyEnv, # from pkgs.neovim
  rustfmt,
  shellcheck,
  shfmt,
  stdenv,
  stylua,
  symlinkJoin,
  tree-sitter,
  xclip,
  prettier,
}:
symlinkJoin {
  name = "neovim";
  paths = [neovim-unwrapped];
  buildInputs = [makeWrapper];
  postBuild = let
    python = python3.withPackages (pp: with pp; [pynvim black]);
    perlEnv = perl.withPackages (pp: with pp; [NeovimExt MsgPackRaw]);
    # Same host_prog setup that nixpkgs's neovim wrapper generates
    providers = lib.concatStringsSep ";" [
      "vim.g.node_host_prog=[[${neovim-node-client}/bin/neovim-node-host]]"
      "vim.g.perl_host_prog=[[${perlEnv}/bin/perl]]"
      "vim.g.ruby_host_prog=[[${rubyEnv}/bin/neovim-ruby-host]]"
    ];
    path =
      [
        curl
        fd
        git
        nodejs
        perlEnv
        python
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
      --prefix LD_LIBRARY_PATH : ${stdenv.cc.cc.lib}/lib \
      --set GEM_HOME ${rubyEnv}/${rubyEnv.ruby.gemPath} \
      --add-flags '--cmd "lua ${providers}"'

    # Link vi and vim to the wrapped nvim
    ln -s nvim $out/bin/vim
    ln -s nvim $out/bin/vi
  '';
}
