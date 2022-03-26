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

                # cli
                ./programs/cli-tools/archive-utils.nix
                ./programs/cli-tools/bat.nix
                ./programs/cli-tools/btop.nix
                ./programs/cli-tools/delta.nix
                ./programs/cli-tools/exa.nix
                ./programs/cli-tools/fd.nix
                ./programs/cli-tools/ffmpeg.nix
                ./programs/cli-tools/file.nix
                ./programs/cli-tools/jq.nix
                ./programs/cli-tools/killall.nix
                ./programs/cli-tools/neofetch.nix
                ./programs/cli-tools/nix-script.nix
                ./programs/cli-tools/procs.nix
                ./programs/cli-tools/ripgrep.nix
                ./programs/cli-tools/sad.nix
                ./programs/cli-tools/shark-radar.nix
                ./programs/cli-tools/speedtest.nix
                ./programs/cli-tools/tmux.nix
                ./programs/cli-tools/watch.nix
                ./programs/cli-tools/wget.nix
                ./programs/cli-tools/yt-dlp.nix
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

                # cli
                ./programs/cli-tools/archive-utils.nix
                ./programs/cli-tools/bat.nix
                ./programs/cli-tools/btop.nix
                ./programs/cli-tools/delta.nix
                ./programs/cli-tools/exa.nix
                ./programs/cli-tools/fd.nix
                ./programs/cli-tools/ffmpeg.nix
                ./programs/cli-tools/file.nix
                ./programs/cli-tools/jq.nix
                ./programs/cli-tools/killall.nix
                ./programs/cli-tools/neofetch.nix
                ./programs/cli-tools/nix-script.nix
                ./programs/cli-tools/procs.nix
                ./programs/cli-tools/ripgrep.nix
                ./programs/cli-tools/sad.nix
                ./programs/cli-tools/shark-radar.nix
                ./programs/cli-tools/speedtest.nix
                ./programs/cli-tools/tmux.nix
                ./programs/cli-tools/watch.nix
                ./programs/cli-tools/wget.nix
                ./programs/cli-tools/yt-dlp.nix
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

                # cli
                ./programs/cli-tools/archive-utils.nix
                ./programs/cli-tools/bat.nix
                ./programs/cli-tools/btop.nix
                ./programs/cli-tools/delta.nix
                ./programs/cli-tools/exa.nix
                ./programs/cli-tools/fd.nix
                ./programs/cli-tools/ffmpeg.nix
                ./programs/cli-tools/file.nix
                ./programs/cli-tools/jq.nix
                ./programs/cli-tools/killall.nix
                ./programs/cli-tools/neofetch.nix
                ./programs/cli-tools/nix-script.nix
                ./programs/cli-tools/procs.nix
                ./programs/cli-tools/ripgrep.nix
                ./programs/cli-tools/sad.nix
                ./programs/cli-tools/shark-radar.nix
                ./programs/cli-tools/speedtest.nix
                ./programs/cli-tools/tmux.nix
                ./programs/cli-tools/watch.nix
                ./programs/cli-tools/wget.nix
                ./programs/cli-tools/yt-dlp.nix

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
