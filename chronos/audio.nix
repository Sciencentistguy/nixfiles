{
  pkgs,
  lib,
  ...
}: let
  rnnoise-plugin' = assert lib.versionOlder pkgs.rnnoise-plugin "1.03";
    {
      lib,
      stdenv,
      SDL2,
      fetchFromGitHub,
      cmake,
      pkg-config,
      alsa-lib,
      freetype,
      xorg,
      webkitgtk,
      gtk3-x11,
    }:
      stdenv.mkDerivation rec {
        pname = "rnnoise-plugin";
        version = "1.03";

        src = fetchFromGitHub {
          owner = "werman";
          repo = "noise-suppression-for-voice";
          rev = "v${version}";
          sha256 = "sha256-1DgrpGYF7G5Zr9vbgtKm/Yv0HSdI7LrFYPSGKYNnNDQ=";
        };

        nativeBuildInputs = [cmake pkg-config];

        buildInputs = [
          alsa-lib
          freetype
          SDL2

          webkitgtk
          gtk3-x11

          xorg.libX11
          xorg.libXrandr
        ];

        cmakeFlags = [
          "-DCMAKE_BUILD_TYPE=Release"
        ];
      };

  rnnoise-plugin = pkgs.callPackage rnnoise-plugin' {};

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
in {
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    media-session.enable = false;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    config.pipewire = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.allowed-rates" = [44100 48000 88200 96000 176400 192000 352800 384000];
      };

      # "context.modules" = [
      # {
      # name = "libpipewire-module-filter-chain";
      # args = {
      # "node.description" = "Noise Canceling source";
      # "media.name" = "Noise Canceling source";
      # "filter.graph" = {
      # nodes = [
      # {
      # type = "ladspa";
      # name = "rnnoise";
      # plugin = "${rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";
      # label = "noise_suppressor_mono";
      # control = {
      # "VAD Threshold (%)" = 50.0;
      # "VAD Grace Period (ms)" = 200;
      # "Retroactive VAD Grace (ms)" = 0;
      # };
      # }
      # ];
      # };
      # "capture.props" = {
      # "node.name" = "capture.rnnoise_source";
      # "node.passive" = true;
      # "audio.rate" = 48000;
      # };
      # "playback.props" = {
      # "node.name" = "rnnoise_source";
      # "media.class" = "Audio/Source";
      # "audio.rate" = 48000;
      # };
      # };
      # }
      # ];
    };
  };
  environment.etc."pipewire/pipewire.conf.d/99-input-denoising.conf" = {
    source = (pkgs.formats.json {}).generate "99-input-denoising.conf" pw_rnnoise_cfg;
  };
}
