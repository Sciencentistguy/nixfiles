{...}: {
  programs.reel = {
    enable = true;
    settings = {
      library = {
        movies = "/media/Films";
        tv = "/media/TV";
      };
      import = {
        operation = "remux";
        timid = true;
      };
      metadata = {
        tmdb_api_key_file = "/secrets/tmdb_api_key";
        tvdb_api_key_file = "/secrets/tvdb_api_key";
      };
    };
  };
}
