{isNixOS, ...}: {
  imports = [
    ./environment.nix
    ./aliases.nix
    ./functions.nix
    ./path.nix
    ./plugins.nix
  ];

  # Purely static files
  home.file.".zshrc".source = ./zshrc;

  zsh.isNixOS = isNixOS;

  zsh.aliases.regular = {
    g = "git";
  };
}
