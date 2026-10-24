{
  pkgs,
  flakePkgs,
  ...
}: {
  programs.firefox = {
    enable = true;
    configPath = ".mozilla/firefox"; # explicitly use old default behaviour
    profiles.default = {
      id = 0;
      path = "1kho4q2t.default";
      settings = {
        # gfxInfo blocklists VA-API on NVIDIA; override it
        "media.ffmpeg.vaapi.enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;
      };
    };
  };

  # nvidia-vaapi-driver needs these, and can't run inside Firefox's RDD sandbox
  home.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    NVD_BACKEND = "direct";
    MOZ_DISABLE_RDD_SANDBOX = "1";
  };

  home.packages = [pkgs.google-chrome flakePkgs.helium];
}
