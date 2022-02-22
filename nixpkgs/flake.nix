{
  description = "Jamie's nix system configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Environment/system management
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Other sources
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";
    naersk.url = "github:nix-community/naersk";
    naersk.inputs.nixpkgs.follows = "nixpkgs";
    flake-compat = { url = "github:edolstra/flake-compat"; flake = false; };
    flake-utils.url = "github:numtide/flake-utils";
    custompkgs = {
      url = "github:Sciencentistguy/custompkgs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.naersk.follows = "naersk";
      # flake =true;
    };
  };

  outputs = inputs@{ self, nixpkgs, darwin, home-manager, flake-utils, ... }:
    let
      nixpkgsConfig = {
        inherit (self) overlays;

        config = {
          allowUnfree = true;
        };
      };

      homeManagerStateVersion = "22.05";
      homeManagerCommonConfig = {
        imports = [
          ./home/common.nix
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
            # nix.nixPath = { nixpkgs = "$HOME/.config/nixpkgs/nixpkgs.nix"; };
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
        inputs.custompkgs.overlay
        # Patch bat to just output `<EMPTY>` instead of `STDIN: <EMPTY>` on empty stdin
        (final: orig: {
          bat = orig.bat.overrideAttrs
            (oldAttrs: {
              patches = oldAttrs.patches or [ ] ++ [
                ./patches/bat.patch
              ];
              # The patch changes output, so don't run tests as they'll fail
              doCheck = false;
            });
        }
        )
      ];
    };
}
