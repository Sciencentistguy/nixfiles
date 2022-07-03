{
  pkgs,
  flakePkgs,
  inputs,
  isDarwin,
  lib,
  ...
}: let
  # build neovim nightly rather than the most recent release in nixpkgs
  # also link vi and vim to nvim
  neovim' = flakePkgs.neovim.overrideAttrs (old: {
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

          # Linters
          shellcheck

          # Formatters
          stylua
          alejandra
          nodePackages.prettier

          # Language servers
          flakePkgs.rust-analyzer
          sumneko-lua-language-server
          nodePackages.pyright
          rnix-lsp
        ]
        ++ lib.optionals (!isDarwin) [
          pkgs.xclip
        ])}
    '';
  };
in {
  home.packages = [neovim];

  home.file.".config/nvim/init.lua".source = "${inputs.dotfiles}/nvim/init.lua";

  home.file.".config/nvim/coq-user-snippets".source = "${inputs.dotfiles}/nvim/coq-user-snippets";
  home.file.".config/nvim/spell".source = "${inputs.dotfiles}/nvim/spell/en.utf-8.add";

  home.file.".config/nvim/lua/user/autopair.lua".source = "${inputs.dotfiles}/nvim/lua/user/autopair.lua";
  home.file.".config/nvim/lua/user/comment.lua".source = "${inputs.dotfiles}/nvim/lua/user/comment.lua";
  home.file.".config/nvim/lua/user/lsp.lua".source = "${inputs.dotfiles}/nvim/lua/user/lsp.lua";
  home.file.".config/nvim/lua/user/plugins.lua".source = "${inputs.dotfiles}/nvim/lua/user/plugins.lua";
  home.file.".config/nvim/lua/user/statusbar.lua".source = "${inputs.dotfiles}/nvim/lua/user/statusbar.lua";
  home.file.".config/nvim/lua/user/vim-opts.lua".source = "${inputs.dotfiles}/nvim/lua/user/vim-opts.lua";
  home.file.".config/nvim/lua/user/vimtex.lua".source = "${inputs.dotfiles}/nvim/lua/user/vimtex.lua";

  home.file.".config/nvim/lua/user/neoformat.lua".source = pkgs.stdenv.mkDerivation {
    name = "neoformat.lua";
    src = "${inputs.dotfiles}/nvim/lua/user";
    dontBuild = true;
    # I'd love to use `build-support/substitute` here,
    # but alas https://github.com/NixOS/nixpkgs/issues/178438
    patchPhase = ''
      substituteInPlace neoformat.lua \
       --replace "exe = \"shfmt\"" "exe = \"${pkgs.shfmt}/bin/shfmt\"" \

      substituteInPlace neoformat.lua \
       --replace "exe = \"prettier\"" "exe = \"${pkgs.nodePackages.prettier}/bin/prettier\""

      substituteInPlace neoformat.lua \
       --replace "exe = \"rustfmt\"" "exe = \"${pkgs.rustfmt}/bin/rustfmt\"" \
    '';
    installPhase = ''
      install -Dm644 neoformat.lua $out
    '';
  };
}
