{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.zsh.aliases;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;

  defaultRegular = {
    ":q" = "exit";
    cp =
      if isDarwin
      then "cp -av"
      else "cp -av --reflink=auto";
    dc = "cd";
    df = "df -h";
    du = "du -sh";
    e = "search-edit";
    ex = "extract";
    feh = "feh --conversion-timeout 1";
    fex =
      if isDarwin
      then "open ."
      else "nautilus . 2>/dev/null";
    ffmpeg = "ffmpeg -hide_banner";
    ffplay = "ffplay -hide_banner";
    ffprobe = "ffprobe -hide_banner";
    gdd = "git -c diff.external=difft diff";
    gla = "git-pull-all";
    less = "less -R";
    mc = "make clean";
    mkdir = "mkdir -p";
    mm = "make -j$(nproc)";
    mount = "sudo mount";
    mpvs = "mpv-search";
    mv = "mv -v";
    ncmpcpp = "ncmpcpp -q";
    poweroff = "sudo poweroff";
    reboot = "sudo reboot";
    rg = "rg -S";
    rm = "rm -rfv";
    rsync = "rsync -Pva";
    sl = "ls";
    sudo = "sudo ";
    umount = "sudo umount";
    xclip = "xclip -selection clipboard";
    fzf = "fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'";
    ls = "eza -lhgbHm --git ";
    lst = "eza -lhgbHmT --git --git-ignore";
    lstg = "eza -lhgbHmT --git";
    lsa = "eza -lhgbHma --git";
    lsat = "eza -lhgbHmaT --git";
  };

  # Replaces the oh-my-zsh git plugin; only the aliases that are actually used
  defaultGit = {
    gaa = "git add --all";
    gc = "git commit --verbose";
    gp = "git push";
    gst = "git status";
    gl = "git pull";
    grh = "git reset";
    grhh = "git reset --hard";
    gloga = "git log --oneline --decorate --graph --all";
    gpf = "git push --force-with-lease --force-if-includes";
    gfa = "git fetch --all --tags --prune --jobs=10";
    gsta = "git stash push";
    ga = "git add";
    gstp = "git stash pop";
    gstd = "git stash drop";
    gcl = "git clone --recurse-submodules";
    gco = "git checkout";
    glo = "git log --oneline --decorate";
    gdca = "git diff --cached";
    gb = "git branch";
    glog = "git log --oneline --decorate --graph";
    "gpf!" = "git push --force";
    gsu = "git submodule update";
    gstl = "git stash list";
    grbc = "git rebase --continue";
    gbsb = "git bisect bad";
    gr = "git remote";
    gf = "git fetch";
    gra = "git remote add";
    gg = "git gui citool";
    gds = "git diff --staged";
    gca = "git commit --verbose --all";
    gbsg = "git bisect good";
    grbi = "git rebase --interactive";
    gpd = "git push --dry-run";
    glods = "git log --graph --pretty=\"%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset\" --date=short";
    gcam = "git commit --all --message";
    gts = "git tag --sign";
    gsts = "git stash show --patch";
    gstall = "git stash --all";
    gstaa = "git stash apply";
    gss = "git status --short";
    grrm = "git remote remove";
    grev = "git revert";
    grb = "git rebase";
    gm = "git merge";
    glod = "git log --graph --pretty=\"%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset\"";
    glg = "git log --stat";
    gfo = "git fetch origin";
    gdt = "git diff-tree --no-commit-id --name-only -r";
    gga = "git gui citool --amend";
    gcf = "git config --list";
    gbs = "git bisect";
    gap = "git apply";
    gd = "git diff";
  };

  defaultGlobal = {
    sd = "~/ScratchArea";
    dl = "~/Downloads";
    "..." = "../..";
    "...." = "../../..";
    "....." = "../../../..";
  };

  reg = defaultRegular // defaultGit // cfg.regular;
  glob = defaultGlobal // cfg.global;
in {
  options.zsh.aliases = {
    regular = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
    };
    global = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
    };
  };

  config.home.file.".zsh/aliases.zsh".text = ''
    ${lib.concatStringsSep "\n" (lib.mapAttrsToList (k: v: "alias ${lib.escapeShellArg k}=${lib.escapeShellArg v}") reg)}
    ${lib.concatStringsSep "\n" (lib.mapAttrsToList (k: v: "alias -g ${lib.escapeShellArg k}=${lib.escapeShellArg v}") glob)}
  '';
}
