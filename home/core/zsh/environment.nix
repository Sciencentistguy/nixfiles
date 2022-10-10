{escapeShellArg}: {
  GPG_TTY = "$(tty)";
  MAKEFLAGS = "-j$(nproc)";
  NODE_OPTIONS = escapeShellArg "--max_old_space_size=16384";
  RUST_BACKTRACE = "1";
  XDG_DATA_DIRS = "$HOME/.nix-profile/share:$HOME/.share:\"\${XDG_DATA_DIRS:-/usr/local/share/:/usr/share/}\"";
  EDITOR = "nvim";
  VISUAL = "nvim";
  FZF_DEFAULT_COMMAND = escapeShellArg "rg --files";
  HISTFILE = "$HOME/.zsh_history";
  HISTSIZE = "10000000";
  SAVEHIST = "10000";
}
