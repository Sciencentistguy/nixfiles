{
  pkgs,
  flakePkgs,
  ...
}: {
  home.packages = with pkgs; [
    bzip2
    gzip
    unzip
    xz
    zip

    (_7zz.overrideAttrs (old: {
      postInstall = ''
        ln $out/bin/7zz $out/bin/7z
      '';
    }))
  ];
}
