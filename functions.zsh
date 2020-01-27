mkcdir() {
    mkdir -p -- "$1" &&
        cd -P -- "$1"
}

reload-zshrc() {
    source ~/.zshrc
}

imgpaste() {
    xclip -t image/png -o >$1
}

lls() {
    clear
    ls
}

borderless() {
    xprop -f _MOTIF_WM_HINTS 32c -set _MOTIF_WM_HINTS "0x2, 0x0, 0x0, 0x0, 0x0"
}

borderless-undo() {
    xprop -f _MOTIF_WM_HINTS 32c -set _MOTIF_WM_HINTS "0x2, 0x0, 0x1, 0x0, 0x0"
}

ffcompare() {
    ffplay $1 &
    ffplay $2
}

vmaf() {
    ffmpeg -hwaccel auto -i $1 -hwaccel auto -i $2 -lavfi libvmaf="model_path=/usr/share/model/vmaf_v0.6.1.pkl" -an -f null -
}

ex() {
    if [ -f $1 ]; then
        case $1 in
        *.tar.bz2) tar xjf $1 ;;
        *.tar.gz) tar xzf $1 ;;
        *.tar.xz) tar xf $1 ;;
        *.bz2) bunzip2 $1 ;;
        *.rar) unrar x $1 ;;
        *.gz) gunzip $1 ;;
        *.tar) tar xf $1 ;;
        *.tbz2) tar xjf $1 ;;
        *.tgz) tar xzf $1 ;;
        *.zip) unzip $1 ;;
        *.Z) uncompress $1 ;;
        *.7z) 7z x $1 ;;
        *) echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
