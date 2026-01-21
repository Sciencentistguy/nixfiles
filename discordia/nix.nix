{
  pkgs,
  nixpkgsConfig,
  inputs,
  ...
}: {
  nixpkgs = nixpkgsConfig;

  # nix.enable = true;
  nix.extraOptions = ''
    auto-optimise-store = false # see https://github.com/NixOS/nix/issues/7273
    experimental-features = flakes nix-command pipe-operators
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  nix.settings.trusted-users = [
    "jamie"
  ];

  programs.zsh.variables.NIX_PATH = "/etc/nix/path";

  nix.nixPath = ["/etc/nix/path"];
  # the version of nixpkgs used to build the system
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  environment.etc."nix/path/nixpkgs".source = inputs.nixpkgs;

  # the version of home-manager used to build the system
  nix.registry.home-manager.flake = inputs.home-manager;
  environment.etc."nix/path/home-manager".source = inputs.home-manager;

  # the version of this flake used to build the system
  nix.registry.activeconfig.flake = inputs.self;
  environment.etc."nix/path/activeconfig".source = inputs.self;

  # Fenix
  nix.registry.fenix.flake = inputs.fenix;
  environment.etc."nix/path/fenix".source = inputs.fenix;
}
