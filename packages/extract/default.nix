{
  _7zz,
  bzip2,
  gnutar,
  gzip,
  lib,
  lzip,
  makeWrapper,
  stdenvNoCC,
  unrar,
  unzip,
  xz,
  zstd,
}:
stdenvNoCC.mkDerivation {
  name = "extract.sh";

  src = ./extract.sh;

  nativeBuildInputs = [makeWrapper];

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    install -Dm755 $src $out/bin/extract
    substituteInPlace $out/bin/extract \
      --replace-fail "7z x" "7zz x"
  '';

  postFixup = ''
    wrapProgram $out/bin/extract \
      --set PATH ${lib.makeBinPath [bzip2 gnutar gzip lzip _7zz unrar unzip xz zstd]}
  '';

  meta = with lib; {
    description = "A script to extract many kinds of archive";
    license = licenses.mpl20;
  };
}
