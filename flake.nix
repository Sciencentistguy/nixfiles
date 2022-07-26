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
    beets-file-info = {
      url = "github:Sciencentistguy/beets-file-info";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    bonkbot = {
      url = "github:Sciencentistguy/bonkbot";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-nix-shell = {
      url = "github:Sciencentistguy/rust-nix-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    susbot = {
      url = "github:Sciencentistguy/susbot";
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
        # Afaict it is not possible to overlay specifically the nixpkgs of self.inputs.nix-darwin.
        # Global overlay it is :sigh:
        (
          final: orig: {
            # See https://github.com/LnL7/nix-darwin/issues/477
            nix =
              if final.stdenv.isDarwin
              then
                orig.nix.overrideAttrs (old: {
                  patches =
                    (old.patches or [])
                    ++ [
                      ./patches/hush-nix-darwin.patch
                    ];
                })
              else orig.nix;
          }
        )
      ];
    };
    homeManagerStateVersion = "22.05";
    flakePkgs' = system:
      self.packages.${system}
      // inputs.beets-file-info.packages.${system}
      // inputs.bonkbot.packages.${system}
      // inputs.fenix.packages.${system}
      // inputs.neovim.packages.${system}
      // inputs.rust-nix-shell.packages.${system}
      // inputs.susbot.packages.${system}
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
            home-manager.useGlobalPkgs = true;
            home-manager.users.jamie = {
              home.stateVersion = homeManagerStateVersion;
              imports = [
                ./home/core
                ./home/cli-tools
                ./home/dev

                ./home/gui/alacritty
              ];
            };
            home-manager.users.root = {
              home.stateVersion = homeManagerStateVersion;
              imports = [
                ./discordia/root
              ];
            };
          })
        ];
      };

      # Atlas - Server
      nixosConfigurations.atlas = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {
          systemName = "atlas";
          isDarwin = false;
          inherit nixpkgsConfig;
          inherit inputs;
          flakePkgs = flakePkgs' system;
        };
        modules = [
          ./atlas
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
                ];
              };
            }
          )
        ];
      };

      # Chronos - Primary desktop
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
                  ./home/gui/alacritty
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
        shark-radar = pkgsUnfree.callPackage ./packages/shark-radar {};
        starship-sciencentistguy = pkgs.callPackage ./packages/starship-sciencentistguy {
          inherit (pkgs.darwin.apple_sdk.frameworks) Security Foundation Cocoa;
        };
        extract = pkgsUnfree.callPackage ./packages/extract {};
        sherlock = pkgs.callPackage ./packages/sherlock {};
        otf-apple = pkgsUnfree.callPackage ./packages/otf-apple {};
        ttf-ms-win11 = pkgsUnfree.callPackage ./packages/ttf-ms-win11 {};
        search-edit = pkgs.callPackage ./packages/search-edit {};
        apple-cursor-theme = pkgs.callPackage ./packages/apple-cursor-theme {};
      };
    }));
}
