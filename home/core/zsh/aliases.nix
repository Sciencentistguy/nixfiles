{
  regular = {
    ":q" = "exit";
    cp = "cp -av --reflink=auto";
    dc = "cd";
    df = "df -h";
    du = "du -sh";
    e = "search-edit";
    ex = "extract";
    feh = "feh --conversion-timeout 1";
    fex = "nautilus . 2>/dev/null";
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
    mv = "mv -v";
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

  global = {
    sd = "~/ScratchArea";
    dl = "~/Downloads";
    "..." = "../..";
    "...." = "../../..";
    "....." = "../../../..";
  };
}
