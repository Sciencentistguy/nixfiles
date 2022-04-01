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
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    videoconverter.url = "github:Sciencentistguy/videoconverter";
    videoconverter.inputs.nixpkgs.follows = "nixpkgs";
    nix-script.url = "github:BrianHicks/nix-script";
    nix-script.inputs.nixpkgs.follows = "nixpkgs";
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
    in
    {
      # Discordia
      darwinConfigurations.discordia = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          system = "discordia";
          inherit nixpkgsConfig;
          inherit inputs;
        };
        modules = [
          ./discordia
          {
            networking.computerName = "discordia";
            networking.hostName = "discordia";
          }
          home-manager.darwinModules.home-manager
          ({ pkgs, home-manager, ... }: {
            # `home-manager` config
            home-manager.extraSpecialArgs = {
              isDarwin = true;
              system = "discordia";
            };
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
      homeConfigurations =
        {
          jamie = inputs.home-manager.lib.homeManagerConfiguration {
            system = "x86_64-linux";
            homeDirectory = "/home/jamie";
            username = "jamie";
            stateVersion = homeManagerStateVersion;
            extraSpecialArgs = {
              isDarwin = false;
              system = "atlas";
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
      nixosConfigurations.chronos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          system = "chronos";
          inherit nixpkgsConfig;
          inherit inputs;
        };
        modules = [
          ./chronos
          home-manager.nixosModules.home-manager
          ({ pkgs, home-manager, ... }: {
            home-manager.extraSpecialArgs = {
              isDarwin = false;
              system = "chronos";
            };
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
        inputs.custompkgs.overlay
        inputs.oxalica.overlay
        inputs.fenix.overlay
        inputs.videoconverter.overlay
        inputs.nix-script.overlay
        # Use sciencentistguy/starship fork
        (final: orig: {
          starship-sciencentistguy = (orig.starship.overrideAttrs (old: rec {
            version = "1.5.4-sciencentistguy";
            src = orig.fetchFromGitHub {
              owner = "sciencentistguy";
              repo = "starship";
              rev = "422ea6518b3c0d6dfe4239e16e96bb356bdda9d7";
              sha256 = "sha256-8ykmVCeUjFUf/mRLJSOWz5fHtcRy/4Zqe22J7wa6guY=";
            };

            cargoDeps = old.cargoDeps.overrideAttrs (orig.lib.const {
              name = "${old.pname}-${version}-vendor.tar.gz";
              inherit src;
              outputHash = "sha256-bRXD/yyFnnrH/dBBcqaFF0AmkqnNJFJtkCMEX8ijd1A=";
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
