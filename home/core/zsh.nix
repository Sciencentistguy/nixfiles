{
  pkgs,
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
}
