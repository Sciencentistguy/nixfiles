{
  pkgs,
  lib,
  inputs,
  ...
}: {
  home.packages = let
    discord = pkgs.callPackage ./discord.nix {};
  in [discord];

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
