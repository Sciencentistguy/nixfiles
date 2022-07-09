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
    ./jq.nix
    ./killall.nix
    ./mpv.nix
    ./neofetch.nix
    ./procs.nix
    ./ripgrep.nix
    ./rsync.nix
    ./rust-nix-shell.nix
    ./sad.nix
    ./shark-radar.nix
    ./speedtest.nix
    ./tmux.nix
    ./watch.nix
    ./wget.nix
    ./yt-dlp.nix
  ];
}
