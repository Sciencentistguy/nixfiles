{
  writeScriptBin,
  dovi-tool,
  ffmpeg,
  zsh,
}:
writeScriptBin "plot-dovi" ''
  #!${zsh}/bin/zsh

  set -euo pipefail

  tempfile=$(mktemp)

  ${ffmpeg}/bin/ffmpeg -i "$1" -c:v copy -bsf:v hevc_mp4toannexb -f hevc - | ${dovi-tool}/bin/dovi_tool extract-rpu - -o "$tempfile"

  # note: this needs zsh not bash due to this fun variable expansion
  ${dovi-tool}/bin/dovi_tool plot "$tempfile" -o "''${"''${1##*/}"%.*}.png"
''
