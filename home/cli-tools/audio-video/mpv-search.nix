{
  writeShellScriptBin,
  skim,
  fd,
}:
# Deliberately using the system mpv
writeShellScriptBin "mpv-search" ''
  filename="$(${skim}/bin/sk -c '${fd}/bin/fd . /media/Music -a')"
  [[ $? -eq 0 && -n "$filename" ]] && exec mpv "$filename" "$@"
''
