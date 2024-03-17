{
  pkgs,
  lib,
  ...
}: let
  pw_rnnoise_cfg = {
    "context.modules" = [
      {
        "name" = "libpipewire-module-filter-chain";
        "args" = {
          "node.description" = "Noise Canceling source";
          "media.name" = "Noise Canceling source";
          "filter.graph" = {
            "nodes" = [
              {
                "type" = "ladspa";
                "name" = "rnnoise";
                "plugin" = "${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";
                "label" = "noise_suppressor_stereo";
                "control" = {
                  "VAD Threshold (%)" = 50.0;
                  "VAD Grace Period (ms)" = 200;
                  "Retroactive VAD Grace (ms)" = 0;
                };
              }
            ];
          };
          "capture.props" = {
            "node.name" = "effect_input.rnnoise";
            "node.passive" = true;
          };
          "playback.props" = {
            "node.name" = "effect_output.rnnoise";
            "media.class" = "Audio/Source";
          };
        };
      }
    ];
  };

  sample_rate_cfg = {
    "context.properties" = {
      "default.clock.rate" = 48000;
      "default.clock.allowed-rates" = [44100 48000 88200 96000 176400 192000 352800 384000];
    };
  };
in {
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.pipewire.configPackages = [
    (
      pkgs.writeTextDir "share/pipewire/config.d/99-input-denoising.conf" ((pkgs.formats.json {}).generate "99-input-denoising.conf" pw_rnnoise_cfg)
    )
    (
      pkgs.writeTextDir "share/pipewire/config.d/98-sample-rates.conf" ((pkgs.formats.json {}).generate "98-sample-rates.conf" sample_rate_cfg)
    )
  ];
}
