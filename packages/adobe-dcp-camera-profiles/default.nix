{
  cpio,
  fetchurl,
  _7zz,
  stdenvNoCC,
  xar,
}:
stdenvNoCC.mkDerivation rec {
  pname = "adobe-dcp-camera-profiles";

  src = fetchurl {
    url = "https://www.adobe.com/go/dng_converter_mac";
    sha256 = "sha256-4M5tGCpdvG36jd40itTknOw7PGvL8UK0ANSIqgcNRM0=";
  };

  version = "18_7";

  nativeBuildInputs = [_7zz xar cpio];

  unpackCmd = ''
    7zz x "$src"
    ls
    cd DNGConverter_${version}
    xar -x -f DNGConverter_${version}.pkg
    cd CameraRawProfiles.pkg
    gzip -d < Payload | cpio --extract
  '';

  sourceRoot = "/build/DNGConverter_${version}/CameraRawProfiles.pkg";

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share
    cp -a CameraProfiles $out/share/
    cp -a LensProfiles $out/share/
  '';
}
