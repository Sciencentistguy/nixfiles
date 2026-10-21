{
  config,
  lib,
  ...
}: let
  cfg = config.zsh.environment-variables;

  default-env = {
    RUST_BACKTRACE = "1";
    EDITOR = "nvim";
    VISUAL = "nvim";
    FZF_DEFAULT_COMMAND = lib.escapeShellArg "rg --files";
  };

  final-env = default-env // cfg;
in {
  options.zsh.environment-variables = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
    default = {};
    description = "Custom environment variables to be exported from .zshenv.";
  };

  # Sourced from .zshenv, so this must stay cheap and idempotent
  config.home.file.".zsh/environment.zsh".text = ''
    typeset -TUx XDG_DATA_DIRS xdg_data_dirs
    (( $#xdg_data_dirs )) || xdg_data_dirs=(/usr/local/share /usr/share)
    xdg_data_dirs=("$HOME/.nix-profile/share" "$HOME/.share" $xdg_data_dirs)

    ${lib.concatStringsSep "\n" (lib.mapAttrsToList (k: v: "export ${k}=${v}") final-env)}
  '';
}
