{
  config,
  isDarwin,
  isNixOS,
  lib,
  writeZsh,
}: let
  path =
    [
      "/run/wrappers/bin" # Note to self: this has to be at the top or sudo stops working
      "${config.home.homeDirectory}/.nix-profile/bin"
      "/run/current-system/sw/bin"
      "/nix/var/nix/profiles/default/bin"
    ]
    ++ lib.optional isDarwin
    "/opt/homebrew/bin"
    ++ lib.optionals (!isNixOS)
    [
      "/bin"
      "/sbin"
      "/usr/bin"
      "/usr/sbin"
      "/usr/local/bin"
    ];
in
  writeZsh "path.zsh" ''export PATH="${lib.concatStringsSep ":" path}:$PATH"''
