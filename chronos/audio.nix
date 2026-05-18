{pkgs, ...}: let
  sample_rate_cfg = {
    "context.properties" = {
      "default.clock.rate" = 48000;
      "default.clock.allowed-rates" = [44100 48000 88200 96000 176400 192000];
    };
  };
in {
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    extraConfig.pipewire = {
      "98-sample-rates" = sample_rate_cfg;
    };
  };
  environment.systemPackages = with pkgs; [easyeffects qpwgraph];
}
