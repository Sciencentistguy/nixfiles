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
    ./gping.nix
    ./hyfetch.nix
    ./jq.nix
    ./killall.nix
    ./mpv.nix
    ./procs.nix
    ./ripgrep.nix
    ./rsync.nix
    ./rust-nix-shell.nix
    ./sad.nix
    ./scripts.nix
    ./shark-radar.nix
    ./speedtest.nix
    ./tmux.nix
    ./watch.nix
    ./wget.nix
    ./yt-dlp.nix
  ];
}
