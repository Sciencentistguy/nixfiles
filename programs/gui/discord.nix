{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [pkgs.discord];


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
