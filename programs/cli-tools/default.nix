{pkgs, ...}: {
  imports = [
    ./archive-utils.nix
    ./bat.nix
    ./btop.nix
    ./comma.nix
    ./exa.nix
    ./fd.nix
    ./ffmpeg.nix
    ./file.nix
    ./rust-nix-shell.nix
    ./jq.nix
    ./killall.nix
    ./mpv.nix
    ./neofetch.nix
    ./procs.nix
    ./ripgrep.nix
    ./sad.nix
    ./shark-radar.nix
    ./speedtest.nix
    ./tmux.nix
    ./unzip.nix
    ./watch.nix
    ./wget.nix
    ./yt-dlp.nix
  ];
}
