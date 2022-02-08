{
  description = "Jamie's darwin system";

  inputs = {
    nixpkgs-master.url = github:NixOS/nixpkgs/master;
    nixpkgs-stable.url = github:NixOS/nixpkgs/nixpkgs-21.11-darwin;
    nixpkgs-unstable.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    nixos-stable.url = github:NixOS/nixpkgs/nixos-21.11;

    # Environment/system management
    darwin.url = github:LnL7/nix-darwin;
    darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";
    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";

    # Other sources
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    naersk.url = "github:nix-community/naersk";
    flake-compat = { url = github:edolstra/flake-compat; flake = false; };
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = inputs@{ self, nixpkgs, darwin, home-manager, flake-utils, ... }:
    let
      nixpkgsConfig = {
        config = {
          allowUnfree = true;
        };
        overlays = self.overlays;
      };

      homeManagerStateVersion = "22.05";
      homeManagerCommonConfig = {
        imports = [
          ./jamie.nix
          { home.stateVersion = homeManagerStateVersion; }
        ];
      };

      nixDarwinModules = [
        ./darwin/configuration.nix
        home-manager.darwinModules.home-manager
        (
          { config, lib, pkgs, ... }:
          {
            nixpkgs = nixpkgsConfig;
            # Hack to support legacy worklows that use `<nixpkgs>` etc.
            nix.nixPath = { nixpkgs = "$HOME/.config/nixpkgs/nixpkgs.nix"; };
            # `home-manager` config
            users.users.jamie.home = "/Users/jamie";
            home-manager.useGlobalPkgs = true;
            home-manager.users.jamie = homeManagerCommonConfig;
            # Add a registry entry for this flake
            nix.registry.my.flake = self;
          }
        )
      ];
    in
    {
      darwinConfigurations =
        {
          discordia = darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            modules = nixDarwinModules ++ [
              {
                networking.computerName = "discordia";
                networking.hostName = "discordia";
              }
            ];
          };
        };

      homeConfigurations =
        {
          jamie = inputs.home-manager.lib.homeManagerConfiguration {
            system = "x86_64-linux";
            homeDirectory = "/home/jamie";
            username = "jamie";
            stateVersion = homeManagerStateVersion;
            configuration = {
              imports = [ homeManagerCommonConfig ];
              nixpkgs = nixpkgsConfig;
            };
          };
        };

      overlays = [
        inputs.neovim-nightly-overlay.overlay
      ];
    };
}
