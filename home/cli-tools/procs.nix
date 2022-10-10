{
  pkgs,
  systemName,
  ...
}: {
  home.packages = with pkgs; [procs];
}
