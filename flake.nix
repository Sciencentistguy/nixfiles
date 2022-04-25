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
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-script = {
      url = "github:BrianHicks/nix-script";
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
  in
    {
      # Discordia
      darwinConfigurations.discordia = darwin.lib.darwinSystem rec {
        system = "aarch64-darwin";
        specialArgs = {
          system = "discordia";
          inherit nixpkgsConfig;
          inherit inputs;
          isDarwin = true;
          flakePkgs = self.packages.${system};
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
                # core
                ./programs/core/atuin.nix
                ./programs/core/coreutils.nix
                ./programs/core/git.nix
                ./programs/core/neovim.nix
                ./programs/core/nix.nix
                ./programs/core/open-sus-sh.nix
                ./programs/core/starship.nix

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
            flakePkgs = self.packages.${system};
          };
          configuration = {
            nixpkgs = nixpkgsConfig;
            imports = [
              # core
              ./programs/core/atuin.nix
              ./programs/core/coreutils.nix
              ./programs/core/git.nix
              ./programs/core/gtk-theme.nix
              ./programs/core/home-manager.nix
              ./programs/core/neovim.nix
              ./programs/core/nix.nix
              ./programs/core/open-sus-sh.nix
              ./programs/core/starship.nix

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
          flakePkgs = self.packages.${system};
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
                  # core
                  ./programs/core/atuin.nix
                  ./programs/core/git.nix
                  ./programs/core/gtk-theme.nix
                  ./programs/core/neovim.nix
                  ./programs/core/nix.nix
                  ./programs/core/open-sus-sh.nix
                  ./programs/core/starship.nix

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
        # inputs.custompkgs.overlay
        inputs.oxalica.overlay
        inputs.fenix.overlay
        inputs.videoconverter.overlay
        inputs.nix-script.overlay
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
