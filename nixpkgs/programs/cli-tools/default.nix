{ pkgs, ... }: {
  imports = [
    ./archive-utils.nix
    ./bat.nix
    ./btop.nix
    ./comma.nix
    ./delta.nix
    ./exa.nix
    ./fd.nix
    ./ffmpeg.nix
    ./file.nix
    ./jq.nix
    ./killall.nix
    ./mpv.nix
    ./neofetch.nix
    ./nix-script.nix
    ./procs.nix
    ./ripgrep.nix
    ./sad.nix
    ./shark-radar.nix
    ./speedtest.nix
    ./tmux.nix
    ./watch.nix
    ./wget.nix
    ./yt-dlp.nix
  ];
}
