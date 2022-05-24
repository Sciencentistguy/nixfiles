{
  pkgs,
  isDarwin,
  ...
}: {
  programs.exa = {
    enable = true;
    enableAliases = false;
  };
}
