{
  lib,
  bash,
  bzip2,
  gnutar,
  gzip,
  p7zip,
  unrar,
  unzip,
  writeTextFile,
}:
writeTextFile {
  name = "ex-script";
  executable = true;
  destination = "/bin/ex";
  text = ''
    #!${bash}/bin/bash

    if [ -f "$1" ]; then
        case $1 in
        *.tar*) ${gnutar}/bin/tar xvf "$1" ;;
        *.bz2) ${bzip2}/bin/bunzip2 "$1" ;;
        *.rar) ${unrar}/bin/unrar x "$1" ;;
        *.gz) ${gzip}/bin/gunzip "$1" ;;
        *.t*z*) ${gnutar}/bin/tar xvf "$1" ;;
        *.zip) ${unzip}/bin/unzip "$1" ;;
        *.Z) ${gzip}/bin/uncompress "$1" ;;
        *.7z) ${p7zip}/bin/7z x "$1" ;;
        *) echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
  '';
  meta = with lib; {
    description = "A bash script to extract many kinds of archive";
    license = licenses.mpl20;
  };
}
