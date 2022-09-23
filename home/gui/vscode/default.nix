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
        # bartoszmaka95.onedark
        jnoortheen.nix-ide
        kamadorueda.alejandra
        ms-python.python
        ms-python.vscode-pylance
        ms-vscode.cpptools
        rust-lang.rust-analyzer
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
      ];

    mutableExtensionsDir = false;
    userSettings = {
      # vscode core settings
      "editor.fontFamily" = "Iosevka Term";
      "editor.minimap.enabled" = false;
      "editor.renderWhitespace" = "trailing";
      "files.autoGuessEncoding" = true;
      "keyboard.dispatch" = "keyCode";
      "telemetry.telemetryLevel" = "off";
      "update.mode" = "none";
      "window.zoomLevel" = 1;
      "workbench.colorTheme" = "onedark.nvim";

      # C/C++
      "C_Cpp.clang_format_path" = "${pkgs.clang-tools}/bin/clang-format";
      "C_Cpp.clang_format_style" = builtins.toJSON clang-format-style;
      "C_Cpp.codeAnalysis.clangTidy.path" = "${pkgs.clang-tools}/bin/clang-tidy";

      # Python
      "python.defaultInterpreterPath" = "${pkgs.python3}/bin/python";
      "python.formatting.blackPath" = "${pkgs.black}/bin/black";
      "python.formatting.provider" = "black";

      #Nix
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "${pkgs.rnix-lsp}/bin/rnix-lsp";

      "vim.normalModeKeyBindings" = bindings.normal;
      "vim.visualModeKeyBindings" = bindings.visual;
      "vim.insertModeKeyBindings" = bindings.insert;

      "vim.enableNeovim" = true;
      "vim.highlightedyank.enable" = true;
      "vim.highlightedyank.textColor" = "#d19a66";
      "vim.leader" = ",";
      "vim.neovimPath" = "${flakePkgs.neovim}/bin/nvim";
      "vim.shell" = "${pkgs.zsh}/bin/zsh";
      "vim.textwidth" = 100;
    };
  };
}
