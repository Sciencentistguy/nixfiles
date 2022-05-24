{
  description = "Jamie's nix system configurations";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };

    # Environment/system management
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Packages
    rust-nix-shell = {
      url = "github:Sciencentistguy/rust-nix-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    videoconverter = {
      url = "github:Sciencentistguy/videoconverter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Libraries
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    flake-utils = {url = "github:numtide/flake-utils";};
    oxalica = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    darwin,
    home-manager,
    flake-utils,
    ...
  }: let
    nixpkgsConfig = {
      inherit (self) overlays;
      config = {
        allowUnfree = true;
      };
    };
    homeManagerStateVersion = "22.05";
    flakePkgs' = system:
      self.packages.${system}
      // inputs.videoconverter.packages.${system}
      // inputs.rust-nix-shell.packages.${system};
  in
    {
      # Discordia
      darwinConfigurations.discordia = darwin.lib.darwinSystem rec {
        system = "aarch64-darwin";
        specialArgs = {
          systemName = "discordia";
          inherit nixpkgsConfig;
          inherit inputs;
          flakePkgs = flakePkgs' system;
          isDarwin = true;
        };
        modules = [
          ./discordia
          {
            networking.computerName = "discordia";
            networking.hostName = "discordia";
          }
          home-manager.darwinModules.home-manager
          ({
            pkgs,
            home-manager,
            ...
          }: {
            # `home-manager` config
            home-manager.extraSpecialArgs = specialArgs;
            # {
            # isDarwin = true;
            # system = "discordia";
            # };
            home-manager.useGlobalPkgs = true;
            home-manager.users.jamie = {
              imports = [
                ./programs/core
                ./programs/cli-tools
              ];
            };
          })
        ];
      };

      # Atlas
      # TODO: Put nixos on atlas
      homeConfigurations = {
        jamie = inputs.home-manager.lib.homeManagerConfiguration rec {
          system = "x86_64-linux";
          homeDirectory = "/home/jamie";
          username = "jamie";
          stateVersion = homeManagerStateVersion;
          extraSpecialArgs = {
            systemName = "chronos";
            isDarwin = false;
            inherit nixpkgsConfig;
            inherit inputs;
            flakePkgs = flakePkgs' system;
          };
          configuration = {
            nixpkgs = nixpkgsConfig;
            imports = [
              ./programs/core
              ./programs/cli-tools
            ];
          };
        };
      };

      # Chronos
      nixosConfigurations.chronos = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {
          systemName = "chronos";
          isDarwin = false;
          inherit nixpkgsConfig;
          inherit inputs;
          flakePkgs = flakePkgs' system;
        };
        modules = [
          ./chronos
          home-manager.nixosModules.home-manager
          (
            {
              pkgs,
              home-manager,
              ...
            }: {
              home-manager.extraSpecialArgs = specialArgs;
              home-manager.users.jamie = {
                home.stateVersion = homeManagerStateVersion;
                nixpkgs = nixpkgsConfig;
                imports = [
                  ./programs/core
                  ./programs/cli-tools

                  # gui
                  ./programs/gui/alacritty.nix
                  ./programs/gui/discord.nix
                  ./programs/gui/dolhin-emu.nix
                  ./programs/gui/drawio.nix
                  ./programs/gui/firefox.nix
                  ./programs/gui/gitkraken.nix
                  ./programs/gui/polymc.nix
                  ./programs/gui/slack.nix
                  ./programs/gui/soulseek.nix
                  ./programs/gui/spotify.nix
                  ./programs/gui/vscode.nix

                  # other
                  ./programs/beets.nix
                  ./programs/mpd.nix
                  ./programs/weechat.nix
                ];
              };
            }
          )
        ];
      };

      overlays = [
        inputs.neovim-nightly-overlay.overlay
        inputs.oxalica.overlay
        inputs.fenix.overlay
        (
          self: super: {
            python = super.python.override {
              packageOverrides = python-self: python-super: {
                pyopenssl = python-super.pyopenssl.overrideAttrs (old: {
                  # See: https://github.com/NixOS/nixpkgs/pull/172397,
                  # https://github.com/pyca/pyopenssl/issues/87
                  # This is (imo) better than just marking it broken and not letting aarch64-darwin
                  # use nix
                  meta = old.meta // {broken = false;};
                });
              };
            };
          }
        )
      ];
    }
    // (flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages = {
        shark-radar = pkgs.callPackage ./packages/shark-radar {};
        beets-file-info = pkgs.callPackage ./packages/beets-file-info {};
        starship-sciencentistguy = pkgs.callPackage ./packages/starship-sciencentistguy {
          inherit (pkgs.darwin.apple_sdk.frameworks) Security Foundation Cocoa;
        };
      };
    }));
}
