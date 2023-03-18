{lib, ...}: {
  home.file.".ghc/ghci.conf".text = let
    lines = [
      ''prompt "\x1b[1m\x03BB>>\x1b[0m "''
      ''prompt-cont "\x1b[1m >>\x1b[0m "''

      ''+t''
      ''+c''

      ''"-Wall"''
      ''"-Wno-type-defaults"''
      ''"-Wno-unused-imports"''
      ''"-Wno-name-shadowing"''
      ''"-Wno-name-shadowing"''

      ''-XBlockArguments''
      ''-XFlexibleContexts''
    ];
    generateSetLine = x: ":set ${x}";
  in
    lib.concatStringsSep "\n" (builtins.map generateSetLine lines);
}
