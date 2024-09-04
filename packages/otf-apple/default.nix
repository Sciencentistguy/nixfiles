{
  stdenv,
  lib,
  p7zip,
  fetchurl,
}:
stdenv.mkDerivation {
  name = "otf-apple";

  src = [
    (fetchurl {
      url = "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg";
      sha256 = "sha256-B8xljBAqOoRFXvSOkOKDDWeYUebtMmQLJ8lF05iFnXk=";
    })
    (fetchurl {
      url = "https://devimages-cdn.apple.com/design/resources/download/SF-Compact.dmg";
      sha256 = "sha256-L4oLQ34Epw1/wLehU9sXQwUe/LaeKjHRxQAF6u2pfTo=";
    })
    (fetchurl {
      url = "https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg";
      sha256 = "sha256-Uarx1TKO7g5yVBXAx6Yki065rz/wRuYiHPzzi6cTTl8=";
    })
    (fetchurl {
      url = "https://devimages-cdn.apple.com/design/resources/download/NY.dmg";
      sha256 = "sha256-yYyqkox2x9nQ842laXCqA3UwOpUGyIfUuprX975OsLA=";
    })
  ];

  nativeBuildInputs = [p7zip];

  sourceRoot = "./";

  preUnpack = "mkdir fonts";

  unpackCmd = ''
    7z x $curSrc >/dev/null
    dir="$(find . -not \( -path ./fonts -prune \) -type d | sed -n 2p)"
    cd $dir 2>/dev/null
    7z x *.pkg >/dev/null
    7z x Payload~ >/dev/null
    mv Library/Fonts/*.otf ../fonts/
    cd ../
    rm -R $dir
  '';

  installPhase = ''
    mkdir -p $out/share/fonts/opentype/{SF\ Pro,SF\ Mono,SF\ Compact,New\ York}
    cp -a fonts/SF-Pro*.otf $out/share/fonts/opentype/SF\ Pro
    cp -a fonts/SF-Mono*.otf $out/share/fonts/opentype/SF\ Mono
    cp -a fonts/SF-Compact*.otf $out/share/fonts/opentype/SF\ Compact
    cp -a fonts/NewYork*.otf $out/share/fonts/opentype/New\ York
  '';
  meta.license = lib.licenses.unfree;
}
