{
  pkgs,
  isDarwin,
  ...
}: {
  programs.eza = {
    enable = true;
    enableAliases = false;
  };
}
