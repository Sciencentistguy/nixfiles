{...}: {
  services.prometheus = {
    enable = true;
    scrapeConfigs = [
      {
        job_name = "deluge_local";
        static_configs = [{targets = ["127.0.0.1:9354"];}];
      }
      {
        job_name = "deluge_remote";
        static_configs = [{targets = ["127.0.0.1:9355"];}];
      }
      {
        job_name = "awair";
        static_configs = [{targets = ["127.0.0.1:8888"];}];
      }
    ];
    extraFlags = [
      "--storage.tsdb.retention=10y"
    ];
  };
}
