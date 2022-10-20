{
  pkgs,
  flakePkgs,
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
        haskell.haskell
        jnoortheen.nix-ide
        justusadam.language-haskell
        kamadorueda.alejandra
        ms-python.python
        ms-python.vscode-pylance
        ms-vscode.cpptools
        rust-lang.rust-analyzer
        timonwong.shellcheck
        vadimcn.vscode-lldb
        vscodevim.vim
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "onedark";
          publisher = "bartoszmaka95";
          version = "0.2.0";
          sha256 = "sha256-5yhIDyR0bU4HHEiGn5ZvFxfYOvp96FrnEe/ITfMSqpY=";
        }
        {
          # `pkgs.vscode-extensions.github.copilot` is massively outdated
          name = "copilot";
          publisher = "github";
          version = "1.46.6822";
          sha256 = "sha256-L71mC0190ZubqNVliu7es4SDsBTGVokePpcNupABI8Q=";
        }
        {
          name = "makefile-tools";
          publisher = "ms-vscode";
          version = "0.6.0";
          sha256 = "sha256-Sd1bLdRBdLVK8y09wL/CJF+/kThPTH8MHw2mFQt+6h8=";
        }
      ];

    mutableExtensionsDir = false;
    userSettings = {
      # vscode core settings
      "editor.cursorSurroundingLines" = 7;
      "editor.fontFamily" = "Iosevka Term";
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
          path = "${pkgs.zsh}/bin/zsh";
        };
      };
      "update.mode" = "none";
      "window.zoomLevel" = 1;

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
      "vim.neovimPath" = "${flakePkgs.neovim}/bin/nvim";
      "vim.normalModeKeyBindings" = bindings.normal;
      "vim.shell" = "${pkgs.zsh}/bin/zsh";
      "vim.textwidth" = 100;
      "vim.visualModeKeyBindings" = bindings.visual;

      # Rust-analyzer
      "rust-analyzer.checkOnSave.command" = "clippy";

      # Shellcheck
      "shellcheck.executablePath" = "${pkgs.shellcheck}/bin/shellcheck";

      # Haskell
      "haskell.serverExecutablePath" = "${pkgs.haskell-language-server}/bin/haskell-language-server-wrapper";
    };
  };
}
