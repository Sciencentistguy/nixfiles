{
  pkgs,
  inputs,
  ...
}: {
  virtualisation.docker.enable = true;

  environment.systemPackages = let
    videoconverter = inputs.videoconverter.packages.x86_64-linux.videoconverter;
    ffmpeg = videoconverter.ffmpeg;
  in
    with pkgs; [
      docker-compose
      videoconverter
      ffmpeg
      file
      ripgrep
      btop
      borgbackup
    ];

  #  services.borgbackup.jobs = {
  #    "photos" = {
  #      paths = "/photos";
  #      encryption = {
  #      };
  #    };
  #  };
}
