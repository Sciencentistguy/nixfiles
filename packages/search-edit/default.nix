{
  bash,
  fzf,
  lib,
  writeTextFile,
}:
writeTextFile rec {
  name = "search-edit";
  executable = true;
  destination = "/bin/${name}";

  text = ''
    #!${bash}/bin/bash

    filename=$(${fzf}/bin/fzf)

    case $? in
      0)
        >&2 echo "vim ''${filename}"
        vim $filename
        ;;
      1)
        >&2 echo "No file with that name found"
        exit $?
        ;;
      130)
        exit $?
        ;;
    esac
  '';

  meta = with lib; {
    description = "Interactively open a file for editing.";
    license = licenses.mpl20;
  };
}
