{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.zsh.environment-variables;

  # Your default internal variables
  default-env = {
    GPG_TTY = "$(tty)";
    MAKEFLAGS = "-j$(nproc)";
    NODE_OPTIONS = lib.escapeShellArg "--max_old_space_size=16384";
    RUST_BACKTRACE = "1";
    XDG_DATA_DIRS = "$HOME/.nix-profile/share:$HOME/.share:\"\${XDG_DATA_DIRS:-/usr/local/share/:/usr/share/}\"";
    EDITOR = "nvim";
    VISUAL = "nvim";
    FZF_DEFAULT_COMMAND = lib.escapeShellArg "rg --files";
    HISTFILE = "$HOME/.zsh_history";
    HISTSIZE = "10000000";
    SAVEHIST = "10000";
  };

  # Merge defaults with the user-provided options
  # We use // for attribute merging here
  final-env = default-env // cfg;

  # Create the script content
  env-script = concatStringsSep "\n" (
    mapAttrsToList (k: v: "export ${k}=${v}") final-env
  );
in {
  ### SCHEMA DEFINITION
  options.zsh.environment-variables = mkOption {
    type = types.attrsOf types.str;
    default = {};
    description = "Custom environment variables to be exported in the Zsh env script.";
  };

  ### IMPLEMENTATION
  config = {
    # This writes the file to your nix store.
    # You likely want to link this into your home directory.
    home.file.".zsh/environment.zsh".text = env-script;

    # Alternatively, if you want to use your specific writeZsh function:
    # home.packages = [ (writeZsh "environment.zsh" env-script) ];
  };
}
