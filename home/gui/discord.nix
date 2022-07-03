{
  pkgs,
  lib,
  inputs,
  ...
}: {
  home.packages = let
    # Make makeDesktopItem overrideable
    pkgs' = import "${inputs.nixpkgs}" {
      inherit (pkgs.stdenv) system;
      config.allowUnfree = true;
      overlays = [
        (
          final: orig: {
            makeDesktopItem = orig.lib.makeOverridable orig.makeDesktopItem;
          }
        )
      ];
    };

    discord-flags = [
      "--ignore-gpu-blocklist"
      "--disable-features=UseOzonePlatform"
      "--enable-features=VaapiVideoDecoder"
      "--use-gl=desktop"
      "--enable-gpu-rasterization"
      "--enable-zero-copy"
      "--no-sandbox"
    ];
  in [
    (pkgs'.discord.overrideAttrs (oldAttrs: rec {
      desktopItem = oldAttrs.desktopItem.override {
        exec = "${pkgs'.discord}/bin/Discord " + lib.concatStringsSep " " discord-flags;
      };
      installPhase = builtins.replaceStrings ["${oldAttrs.desktopItem}"] ["${desktopItem}"] oldAttrs.installPhase;
    }))
  ];

  home.file.".config/discord/settings.json" = {
    text = builtins.toJSON {
      "BACKGROUND_COLOR" = "#202225";
      "IS_MAXIMIZED" = true;
      "IS_MINIMIZED" = false;
      # Discord likes to break old versions. Don't do that
      "SKIP_HOST_UPDATE" = true;
    };
  };
}
