{...}: {
  imports = [
    ./base.nix
    ./config.nix
    ./gpg.nix
    ./i18n.nix
    ./time.nix
    ./users.nix
  ];

  programs.zsh.enable = true;

  programs.mosh.enable = true;

  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = flakes nix-command pipe-operators
  '';
}
