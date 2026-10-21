{
  isNixOS,
  pkgs,
  ...
}: {
  imports = [
    ./environment.nix
    ./aliases.nix
    ./functions.nix
    ./path.nix
    ./plugins.nix
  ];

  # Purely static files
  home.file.".zshrc".source = ./zshrc;
  home.file.".zshenv".text = ''
    source "$HOME/.zsh/path.zsh"
    source "$HOME/.zsh/environment.zsh"
  '';

  home.packages = [pkgs.nix-your-shell];

  zsh.isNixOS = isNixOS;

  zsh.aliases.regular = {
    g = "git";
  };
}
