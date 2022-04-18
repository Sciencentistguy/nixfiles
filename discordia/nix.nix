{
  pkgs,
  nixpkgsConfig,
  inputs,
  ...
}: {
  nixpkgs = nixpkgsConfig;

  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = flakes nix-command
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  nix.trustedUsers = [
    "jamie"
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  programs.zsh.variables.NIX_PATH = "/etc/nix/path";

  # specify <nixpkgs>
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
}
