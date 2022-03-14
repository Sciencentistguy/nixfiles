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
    flake-compat = { url = "github:edolstra/flake-compat"; flake = false; };
    flake-utils.url = "github:numtide/flake-utils";
    custompkgs = {
      url = "github:Sciencentistguy/custompkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    oxalica.url = "github:oxalica/rust-overlay";
    oxalica.inputs.nixpkgs.follows = "nixpkgs";
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
        inputs.oxalica.overlay
        # FIXME: this is currently broken
        # Patch bat to just output `<EMPTY>` instead of `STDIN: <EMPTY>` on empty stdin
        # (final: orig: {
        # bat = orig.bat.overrideAttrs
        # (oldAttrs: {
        # patches = oldAttrs.patches or [ ] ++ [
        # ./patches/bat.patch
        # ];
        # # The patch changes output, so don't run tests as they'll fail
        # doCheck = false;
        # });
        # }
        # )
        # Use sciencentistguy/starship fork
        (final: orig: {
          starship-sciencentistguy = (orig.starship.overrideAttrs (old: rec {
            version = "1.4.0-sciencentistguy";
            src = orig.fetchFromGitHub {
              owner = "sciencentistguy";
              repo = "starship";
              rev = "2063ca6b10f5ea3e18ff54b1ccc296dc7f636c2d";
              sha256 = "sha256-jeDXLKeI1LJUiJP+nekoieY3Mcv/qw9mNiLXDh51fV8";
            };

            cargoDeps = old.cargoDeps.overrideAttrs (orig.lib.const {
              name = "${old.pname}-${version}-vendor.tar.gz";
              inherit src;
              outputHash = "sha256-gJ92fxcZNWZKd0MB/y7n3rBva32Ol5TDdIrRvJ9vbMc";
            });
          })).override {
            rustPlatform = orig.makeRustPlatform {
              rustc = orig.rust-bin.stable.latest.default;
              cargo = orig.rust-bin.stable.latest.default;
            };
          };
        }
        )
      ];
    };
}
