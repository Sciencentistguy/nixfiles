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
        *.tar*) tar xvf $1 ;;
        *.bz2) bunzip2 $1 ;;
        *.rar) unrar x $1 ;;
        *.gz) gunzip $1 ;;
        *.t*z*) tar xvf $1 ;;
        *.zip) unzip $1 ;;
        *.Z) uncompress $1 ;;
        *.7z) 7z x $1 ;;
        *) echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

videodownload() {
    cd ~/Videos/
    tmux new -d aria2c $i
    cd -
}

update-music-library() {
    if [ $(hostname) = chronos ]; then
        rsync -Pa --delete ~/Music/beets/ atlas:/nas/plex/Music
        rsync -Pa ~/.config/beets atlas:/nas/plex/Music/beetsconfig
    fi
}

update-music-library-remote() {
    if [ $(hostname) = chronos ]; then
        rsync -Pa --delete ~/Music/beets/ home.jamiequigley.com:/nas/plex/Music
        rsync -Pa ~/.config/beets home.jamiequigley.com:/nas/plex/Music/beetsconfig
    fi
}

aur() {
    git clone "https://aur.archlinux.org/$1"
}

abs() {
    asp update "$1" && asp checkout "$1"
}

cpufreq() {
    watch -n.1 "cat /proc/cpuinfo | grep \"^[c]pu MHz\""
}

git-pull-all() {
    for branch in $(git branch --all | grep '^\s*remotes' | egrep --invert-match '(:?HEAD|master)$'); do
        git branch --track "${branch##*/}" "$branch"
    done
}
