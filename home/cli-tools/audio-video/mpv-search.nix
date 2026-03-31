{
  writeShellScriptBin,
  skim,
  fd,
}:
# Deliberately using the system mpv
writeShellScriptBin "mpv-search" "exec mpv \"$(${skim}/bin/sk -c '${fd}/bin/fd . /media/Music -a')\""
