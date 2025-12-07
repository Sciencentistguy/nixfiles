{
  pkgs,
  flakePkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    keyMode = "vi";
    extraConfig = ''
      set -g mouse on
      set -sg escape-time 10 # https://neovim.io/doc/user/faq.html#_esc-in-tmux-or-gnu-screen-is-delayed
    '';
    historyLimit = 1000000;
    plugins = [
      pkgs.tmuxPlugins.cpu
    ];
  };
}
