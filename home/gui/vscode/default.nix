{
  pkgs,
  config,
  flakePkgs,
  lib,
  ...
}: let
  clang-format-style = import ./clang-format.nix;
  bindings = import ./vim-bindings.nix;
in {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions;
      [
        arrterian.nix-env-selector
        tamasfe.even-better-toml
        dracula-theme.theme-dracula
        haskell.haskell
        jnoortheen.nix-ide
        justusadam.language-haskell
        kamadorueda.alejandra
        ms-python.python
        ms-python.vscode-pylance
        ms-vscode.cpptools
        ms-vscode.cmake-tools
        rust-lang.rust-analyzer
        timonwong.shellcheck
        vadimcn.vscode-lldb
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "language-x86-64-assembly";
          publisher = "13xforever";
          version = "3.0.0";
          sha256 = "sha256-wIsY6Fuhs676EH8rSz4fTHemVhOe5Se9SY3Q9iAqr1M=";
        }
        {
          name = "makefile-tools";
          publisher = "ms-vscode";
          version = "0.6.0";
          sha256 = "sha256-Sd1bLdRBdLVK8y09wL/CJF+/kThPTH8MHw2mFQt+6h8=";
        }
        {
          name = "one-monokai";
          publisher = "azemoh";
          version = "0.5.0";
          sha256 = "sha256-ardM7u9lXkkTTPsDVqTl4yniycERYdwTzTQxaa4dD+c=";
        }
        {
          name = "vim";
          publisher = "vscodevim";
          version = "1.25.1";
          sha256 = "sha256-hSymHde+fuef2mb958zqHPPCAkyP/ClXYvomx6spm3c=";
        }
      ];

    mutableExtensionsDir = false;
    userSettings = {
      # vscode core settings
      "editor.cursorSurroundingLines" = 7;
      "editor.fontFamily" = "IosevkaTerm Nerd Font";
      "editor.fontLigatures" = true;
      "editor.inlineSuggest.enabled" = true;
      "editor.minimap.enabled" = false;
      "editor.renderWhitespace" = "trailing";
      "editor.rulers" = [100];
      "files.autoGuessEncoding" = true;
      "keyboard.dispatch" = "keyCode";
      "telemetry.telemetryLevel" = "off";
      "terminal.integrated.defaultProfile.linux" = "zsh";
      "terminal.integrated.profiles.linux" = {
        zsh = {
          path = let
            zsh = pkgs.zsh;
          in "${pkgs.zsh}/bin/zsh";
        };
      };
      "update.mode" = "none";
      "window.zoomLevel" = 1;
      "workbench.colorTheme" = "One Monokai";
      "workbench.editSessions.autoResume" = "off";
      "workbench.editSessions.continueOn" = "off";
      "workbench.experimental.editSessions.autoStore" = "off";

      # C/C++
      "C_Cpp.clang_format_path" = "${pkgs.clang-tools}/bin/clang-format";
      "C_Cpp.clang_format_style" = clang-format-style;
      "C_Cpp.codeAnalysis.clangTidy.path" = "${pkgs.clang-tools}/bin/clang-tidy";

      # Python
      "python.defaultInterpreterPath" = "${pkgs.python3}/bin/python";
      "python.formatting.blackPath" = "${pkgs.black}/bin/black";
      "python.formatting.provider" = "black";

      # Nix
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "${pkgs.rnix-lsp}/bin/rnix-lsp";

      # Vim
      "vim.enableNeovim" = true;
      "vim.highlightedyank.enable" = true;
      "vim.highlightedyank.textColor" = "#d19a66";
      "vim.insertModeKeyBindings" = bindings.insert;
      "vim.leader" = ",";
      "vim.neovimPath" = "${pkgs.neovim-unwrapped}/bin/nvim";
      "vim.normalModeKeyBindings" = bindings.normal;
      "vim.shell" = "${pkgs.zsh}/bin/zsh";
      "vim.textwidth" = 100;
      "vim.visualModeKeyBindings" = bindings.visual;

      # Rust-analyzer
      "rust-analyzer.checkOnSave.command" = "clippy";
      "rust-analyzer.lens.implementations.enable" = false;
      "rust-analyzer.lens.run.enable" = false;

      # Shellcheck
      "shellcheck.executablePath" = "${pkgs.shellcheck}/bin/shellcheck";

      # Haskell
      "haskell.serverExecutablePath" = "${pkgs.haskell-language-server}/bin/haskell-language-server-wrapper";
    };
  };
}
