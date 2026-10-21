{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.zsh;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;

  pathList =
    [
      "/run/wrappers/bin" # Essential for sudo
      "${config.home.homeDirectory}/.nix-profile/bin"
      "/run/current-system/sw/bin"
      "/nix/var/nix/profiles/default/bin"
    ]
    ++ lib.optional isDarwin "/opt/homebrew/bin"
    ++ lib.optionals (!cfg.isNixOS) [
      "/bin"
      "/sbin"
      "/usr/bin"
      "/usr/sbin"
      "/usr/local/bin"
    ];
in {
  options.zsh.isNixOS = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = ''
      Whether the target system is NixOS.
      If false, standard FHS paths (like /usr/bin) are added to PATH.
    '';
  };

  # Sourced from both .zshenv and .zshrc (macOS's path_helper reorders PATH in
  # between), so it must be idempotent.
  # TODO: `nix shell` does not set IN_NIX_SHELL
  config.home.file.".zsh/path.zsh".text = ''
    if [[ -z $IN_NIX_SHELL ]]; then
        typeset -U path
        export PATH="${lib.concatStringsSep ":" pathList}:$PATH"
    fi
  '';
}
