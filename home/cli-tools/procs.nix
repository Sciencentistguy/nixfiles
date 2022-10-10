{
  pkgs,
  systemName,
  ...
}: {
  home.packages = with pkgs;
    if systemName != "discordia"
    then [procs]
    else [];
}
