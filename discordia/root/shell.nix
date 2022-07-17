{
  pkgs,
  lib,
  ...
}: {
  programs.bash.enable = true;
  programs.bash.initExtra = lib.concatStringsSep "\n" [
    (builtins.readFile ./ps1.bash)
  ];
  # programs.bash.sessionVariables = {
  # "PS1" = "\\[33[1;32m\\][nix-shell:\\w]\\$\\[\\033[0m\\]";
  # };
}
