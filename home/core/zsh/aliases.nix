{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.zsh.aliases;
  isDarwin = pkgs.stdenv.isDarwin;

  defaultRegular = {
    ":q" = "exit";
    cp = "cp -av --reflink=auto";
    dc = "cd";
    df = "df -h";
    du = "du -sh";
    e = "search-edit";
    ex = "extract";
    feh = "feh --conversion-timeout 1";
    fex = if isDarwin then "open ." else "nautilus . 2>/dev/null";
    ffmpeg = "ffmpeg -hide_banner";
    ffplay = "ffplay -hide_banner";
    ffprobe = "ffprobe -hide_banner";
    gla = "git-pull-all";
    less = "less -r";
    makepkg-gcc = "makepkg --config /etc/makepkg.conf.gcc";
    mc = "make clean";
    mkdir = "mkdir -p";
    mm = "make -j$(nproc)";
    mount = "sudo mount";
    mpvs = "mpv-search";
    mv = "mv -v";
    ncmpcpp = "ncmpcpp -q";
    neofetch = "clear; neofetch";
    poweroff = "sudo poweroff";
    reboot = "sudo reboot";
    rg = "rg -S";
    rm = "rm -rfv";
    rsync = "rsync -Pva";
    sl = "ls";
    sudo = "sudo ";
    umount = "sudo umount";
    xclip = "xclip -selection clipboard";
    zshrc-reload = "reload-zshrc";
    fzf = "fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'";
    ls = "exa -lhgbHm --git ";
    lst = "exa -lhgbHmT --git --git-ignore";
    lstg = "exa -lhgbHmT --git";
    lsa = "exa -lhgbHma --git";
    lsat = "exa -lhgbHmaT --git";
  };

  defaultGlobal = {
    sd = "~/ScratchArea";
    dl = "~/Downloads";
    "..." = "../..";
    "...." = "../../..";
    "....." = "../../../..";
  };

  reg = defaultRegular // cfg.regular;
  glob = defaultGlobal // cfg.global;
in {
  options.zsh.aliases = {
    regular = mkOption { type = types.attrsOf types.str; default = {}; };
    global = mkOption { type = types.attrsOf types.str; default = {}; };
  };

  config.home.file.".zsh/aliases.zsh".text = ''
    ${concatStringsSep "\n" (mapAttrsToList (k: v: "alias ${k}=${escapeShellArg v}") reg)}
    ${concatStringsSep "\n" (mapAttrsToList (k: v: "alias -g ${k}=${escapeShellArg v}") glob)}
  '';
}
