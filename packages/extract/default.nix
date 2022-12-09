{
  bzip2,
  fetchgit,
  gnutar,
  gzip,
  lib,
  makeWrapper,
  p7zip,
  stdenvNoCC,
  unrar,
  unzip,
}:
stdenvNoCC.mkDerivation {
  name = "extract.sh";

  src = fetchgit {
    url = "https://gist.github.com/a99876efb08a9b4ae76846cd69274a4b.git";
    rev = "b4858b70caa217d206b0f3b56a28950d8ea90a88";
    sha256 = "sha256-pV1JmpIRMs6gJs48IIca5OR8S2JnT4x41+5kgr4UDfM=";
  };

  nativeBuildInputs = [makeWrapper];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    install -Dm755 extract.sh $out/bin/extract
  '';

  postFixup = ''
    wrapProgram $out/bin/extract \
      --set PATH ${lib.makeBinPath [bzip2 gnutar gzip p7zip unrar unzip]}
  '';

  meta = with lib; {
    description = "A script to extract many kinds of archive";
    license = licenses.mpl20;
  };
}
