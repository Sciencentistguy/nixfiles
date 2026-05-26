{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.zsh;
  isDarwin = pkgs.stdenv.isDarwin;

  # Build the path list based on the options
  pathList =
    [
      "/run/wrappers/bin" # Essential for sudo
      "${config.home.homeDirectory}/.nix-profile/bin"
      "/run/current-system/sw/bin"
      "/nix/var/nix/profiles/default/bin"
    ]
    ++ optional isDarwin "/opt/homebrew/bin"
    ++ optionals (!cfg.isNixOS) [
      "/bin"
      "/sbin"
      "/usr/bin"
      "/usr/sbin"
      "/usr/local/bin"
    ];
in {
  ### SCHEMA DEFINITION
  options.zsh.isNixOS = mkOption {
    type = types.bool;
    default = true;
    description = ''
      Whether the target system is NixOS.
      If false, standard FHS paths (like /usr/bin) are added to PATH.
    '';
  };

  ### IMPLEMENTATION
  config = {
    home.file.".zsh/path.zsh".text = ''
      export PATH="${concatStringsSep ":" pathList}:$PATH"
    '';
  };
}
