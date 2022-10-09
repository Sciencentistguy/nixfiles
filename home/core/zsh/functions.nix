# Attrset of the shape:
# {
#   name = ''
#     body
#   '';
# }
{
  mkcdir = ''
    mkdir -p -- "$1" && cd -P -- "$1"
  '';

  reload-zshrc = ''
    source $HOME/.zshrc
  '';

  imgpaste = ''
    xclip -t image/png -o >$1
  '';

  borderless = ''
    xprop -f _MOTIF_WM_HINTS 32c -set _MOTIF_WM_HINTS "0x2, 0x0, 0x0, 0x0, 0x0"
  '';

  borderless-undo = ''
    xprop -f _MOTIF_WM_HINTS 32c -set _MOTIF_WM_HINTS "0x2, 0x0, 0x1, 0x0, 0x0"
  '';

  ffcompare = ''
    ffplay $1 &
    ffplay $2
  '';

  aur = ''
    git clone "https://aur.archlinux.org/$1"
  '';

  cpufreq = ''
    watch -n0.1 'cat /proc/cpuinfo | grep "^[c]pu MHz" | sort -r'
  '';

  git-pull-all = ''
    for branch in $(git branch --all | grep '^\s*remotes' | egrep --invert-match '(:?HEAD|master)$'); do
        git branch --track "''${branch##*/}" "$branch"
    done
  '';
}
