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
    prism-launcher = {
      url = "github:PrismLauncher/PrismLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-nix-shell = {
      url = "github:Sciencentistguy/rust-nix-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    susbot = {
      url = "github:Sciencentistguy/susbot";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    videoconverter = {
      url = "github:Sciencentistguy/videoconverter";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nil = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Libraries
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
        # ...
      ];
    };
    homeManagerStateVersion = "22.05";
    flakePkgs' = system:
      self.packages.${system}
      // inputs.agenix.packages.${system}
      // inputs.beets-file-info.packages.${system}
      // inputs.bonkbot.packages.${system}
      // inputs.fenix.packages.${system}
      // inputs.nil.packages.${system}
      // inputs.rust-nix-shell.packages.${system}
      // inputs.susbot.packages.${system}
      // inputs.videoconverter.packages.${system}
      // nixpkgs.lib.optionalAttrs (system == "x86_64-linux") (
        inputs.prism-launcher.packages.${system}
      );
  in
    {
      # Atlas - Server
      nixosConfigurations.atlas = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs nixpkgsConfig;
          flakePkgs = flakePkgs' system;
          isDarwin = false;
          isNixOS = true;
          systemName = "atlas";
        };
        modules = [
          ./atlas
          home-manager.nixosModules.home-manager
          inputs.agenix.nixosModules.age
          inputs.bonkbot.nixosModules.${system}.bonkbot
          inputs.susbot.nixosModules.${system}.susbot
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
          inherit inputs nixpkgsConfig;
          flakePkgs = flakePkgs' system;
          isDarwin = false;
          isNixOS = true;
          systemName = "chronos";
        };
        modules = [
          ./chronos
          home-manager.nixosModules.home-manager
          inputs.agenix.nixosModules.age
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
                  ./home/gui/lutris.nix
                  ./home/gui/makemkv.nix
                  ./home/gui/mkvtoolnix.nix
                  ./home/gui/picard.nix
                  ./home/gui/prism-launcher.nix
                  ./home/gui/slack.nix
                  ./home/gui/soulseek.nix
                  ./home/gui/spotify.nix
                  ./home/gui/vlc.nix
                  ./home/gui/vscode

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

      # Discordia - Macbook Pro 2021
      darwinConfigurations.discordia = darwin.lib.darwinSystem rec {
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs nixpkgsConfig;
          flakePkgs = flakePkgs' system;
          isDarwin = true;
          isNixOS = false;
          systemName = "discordia";
        };
        modules = [
          ./discordia

          home-manager.darwinModules.home-manager

          (
            {
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
        update-music-library = pkgs.callPackage ./packages/update-music-library {};
        asp = pkgs.callPackage ./packages/asp {};
      };
    }));
}
