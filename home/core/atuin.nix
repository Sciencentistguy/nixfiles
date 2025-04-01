{...}: {
  programs.atuin = {
    enable = true;
    enableZshIntegration = false;
    settings = {
      dialect = "uk";
      auto_sync = true;
      sync_address = "https://api.atuin.sh";
      search_mode = "fulltext";
    };
    daemon.enable = true;
  };
}
