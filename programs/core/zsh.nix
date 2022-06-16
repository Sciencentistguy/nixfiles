{
  pkgs,
  inputs,
  ...
}: {
  home.file.".zshrc".source = "${inputs.dotfiles}/zshrc";
  home.file.".zsh/functions.zsh".source = "${inputs.dotfiles}/functions.zsh";
  home.file.".zsh/aliases.zsh".source = "${inputs.dotfiles}/aliases.zsh";

  home.file.".zsh/plugins/zsh-autosuggestions".source = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
  home.file.".zsh/plugins/zsh-nix-shell".source = "${pkgs.zsh-nix-shell}/share/zsh-nix-shell";
  home.file.".zsh/plugins/zsh-syntax-highlighting".source = "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting";
  home.file.".zsh/plugins/zsh-vim-mode".source = let
    zsh-vim-mode = pkgs.fetchFromGitHub {
      owner = "softmoth";
      repo = "zsh-vim-mode";
      rev = "1f9953b7d6f2f0a8d2cb8e8977baa48278a31eab";
      sha256 = "sha256-a+6EWMRY1c1HQpNtJf5InCzU7/RphZjimLdXIXbO6cQ=";
    };
  in "${zsh-vim-mode}";

  home.file.".zsh/plugins/git.plugin.zsh".source = "${inputs.dotfiles}/zsh-plugins/git.plugin.zsh";
  home.file.".zsh/plugins/globalias.plugin.zsh".source = "${inputs.dotfiles}/zsh-plugins/globalias.plugin.zsh";
}
