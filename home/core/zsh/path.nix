{
  lib,
  isDarwin,
  isNixOS,
  config,
}:
[
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
]
