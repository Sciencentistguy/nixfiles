{pkgs, ...}: {
  home.packages = with pkgs; [atuin];
  xdg.configFile."atuin/config.toml".source = (pkgs.formats.toml {}).generate "atuin-config" {
    dialect = "uk";
    auto_sync = true;
    sync_address = "https://api.atuin.sh";
    search_mode = "fulltext";
  };
}
