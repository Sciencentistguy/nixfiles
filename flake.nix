{
  description = "Jamie's nix system configurations";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };
    nixpkgs-unfree = {
      url = "github:numtide/nixpkgs-unfree";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dotfiles = {
      url = "github:Sciencentistguy/dotfiles";
      flake = false;
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
    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    videoconverter = {
      url = "github:Sciencentistguy/videoconverter";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-unfree.follows = "nixpkgs-unfree";
    };
    polymc = {
      url = "github:PolyMC/PolyMC";
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
      config = {
        allowUnfree = true;
      };
      overlays = [
        (
          final: orig: {
            makeDesktopItem = orig.lib.makeOverridable orig.makeDesktopItem;
          }
        )
      ];
    };
    homeManagerStateVersion = "22.05";
    flakePkgs' = system:
      self.packages.${system}
      // inputs.fenix.packages.${system}
      // inputs.neovim.packages.${system}
      // inputs.rust-nix-shell.packages.${system}
      // inputs.videoconverter.packages.${system}
      // (
        if (system == "x86_64-linux")
        then inputs.polymc.packages.${system}
        else {}
      );
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
              home.stateVersion = homeManagerStateVersion;
              imports = [
                ./home/core
                ./home/cli-tools
                ./home/dev
              ];
            };
          })
        ];
      };

      # Atlas
      # TODO: Put nixos on atlas
      homeConfigurations = {
        jamie = inputs.home-manager.lib.homeManagerConfiguration rec {
          pkgs = inputs.nixpkgs.legacyPackages.${system};
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
              ./home/core
              ./home/cli-tools
              ./home/dev
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
                  ./home/core
                  ./home/cli-tools
                  ./home/dev

                  # gui
                  ./home/gui/alacritty.nix
                  ./home/gui/discord
                  ./home/gui/dolhin-emu.nix
                  ./home/gui/drawio.nix
                  ./home/gui/firefox.nix
                  ./home/gui/gitkraken.nix
                  ./home/gui/polymc.nix
                  ./home/gui/slack.nix
                  ./home/gui/soulseek.nix
                  ./home/gui/spotify.nix
                  ./home/gui/vscode.nix

                  # other
                  ./home/beets.nix
                  ./home/mpd.nix
                  ./home/weechat.nix
                ];
              };
            }
          )
        ];
      };
    }
    // (flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      pkgsUnfree = inputs.nixpkgs-unfree.legacyPackages.${system};
    in {
      packages = {
        shark-radar = pkgs.callPackage ./packages/shark-radar {};
        beets-file-info = pkgs.callPackage ./packages/beets-file-info {};
        starship-sciencentistguy = pkgs.callPackage ./packages/starship-sciencentistguy {
          inherit (pkgs.darwin.apple_sdk.frameworks) Security Foundation Cocoa;
        };
        ex = pkgsUnfree.callPackage ./packages/ex {};
        sherlock = pkgs.callPackage ./packages/sherlock {};
        otf-apple = pkgsUnfree.callPackage ./packages/otf-apple {};
        ttf-ms-win11 = pkgsUnfree.callPackage ./packages/ttf-ms-win11 {};
      };
    }));
}
