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
    rev = "d9978592df5ab8d10ed1d21bbfebd28eaa3818e4";
    sha256 = "sha256-8GGBju/wLU9PQ8oi6XPV0mWoqAOb554OVsgmD99DHzg=";
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
