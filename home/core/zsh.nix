{
  pkgs,
  lib,
  inputs,
  flakePkgs,
  ...
}: {
  home.packages = with flakePkgs; [search-edit];

  home.file.".zshrc".source = "${inputs.dotfiles}/zshrc";
  home.file.".zsh/functions.zsh".source = "${inputs.dotfiles}/functions.zsh";
  home.file.".zsh/aliases.zsh".source = "${inputs.dotfiles}/aliases.zsh";

  home.file.".zsh/plugins/zsh-autosuggestions".source = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
  home.file.".zsh/plugins/zsh-nix-shell".source = "${pkgs.zsh-nix-shell}/share/zsh-nix-shell";
  home.file.".zsh/plugins/zsh-syntax-highlighting".source = "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting";
  home.file.".zsh/plugins/zsh-vi-mode".source = "${pkgs.zsh-vi-mode}/share/zsh-vi-mode/";

  home.file.".zsh/plugins/git.plugin.zsh".source = "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/git/git.plugin.zsh";
  home.file.".zsh/plugins/globalias.plugin.zsh".source = "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/globalias/globalias.plugin.zsh";

  # Another nixos-module import from home-manager. I'd quite like it if this wasn't as hideous as it is.
  home.file.".zsh/command-not-found.zsh".text = let
    raw-nixos-module = import "${inputs.nixpkgs}/nixos/modules/programs/command-not-found/command-not-found.nix";
    dbPath =
      (raw-nixos-module {
        inherit pkgs lib;
        config = {};
      })
      .options
      .programs
      .command-not-found
      .dbPath
      .default;
    nixos-module = raw-nixos-module {
      inherit pkgs lib;
      config = {
        programs.command-not-found.enable = true;
        programs.command-not-found.dbPath = dbPath;
      };
    };
  in
    nixos-module.config.content.programs.zsh.interactiveShellInit;
}
