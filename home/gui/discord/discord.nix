{
  lib,
  discord,
  firefox-unwrapped,
}: let
  discord-flags = [
    "--ignore-gpu-blocklist"
    "--disable-features=UseOzonePlatform"
    "--enable-features=VaapiVideoDecoder"
    "--use-gl=desktop"
    "--enable-gpu-rasterization"
    "--enable-zero-copy"
    "--no-sandbox"
  ];

  searchName = name: drv:
    name
    == (builtins.head
      (lib.splitString
        "-"
        drv.name));

  nss =
    lib.findSingle
    (searchName "nss")
    (throw "Could not find firefox nss")
    (throw "Firefox had multiple nss?")
    firefox-unwrapped.buildInputs;
in
  discord.overrideAttrs (oldAttrs: rec {
    unwrappedDiscord = oldAttrs.unwrappedDiscord.overrideAttrs (old: {
      desktopItem = oldAttrs.desktopItem.override {
        exec = "${discord}/bin/Discord " + lib.concatStringsSep " " discord-flags;
      };
      installPhase = builtins.replaceStrings ["${oldAttrs.desktopItem}"] ["${desktopItem}"] oldAttrs.installPhase;
    });
  })
