{pkgs, ...}: {
  programs.tmux.enable = true;
  programs.tmux.aggressiveResize = true;
  programs.tmux.keyMode = "vi";
  programs.tmux.extraConfig = ''
    set -g mouse on
  '';
  programs.tmux.historyLimit = 1000000;
}
