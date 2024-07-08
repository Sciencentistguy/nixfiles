{
  cpio,
  fetchurl,
  p7zip,
  stdenvNoCC,
  xar,
}:
stdenvNoCC.mkDerivation {
  name = "adobe-dcp-camera-profiles";

  src = fetchurl {
    url = "https://www.adobe.com/go/dng_converter_mac";
    sha256 = "sha256-CFlT6TCvY6eJLXdszTM/QeInXhRskI4UnqcLwQYh1Yk=";
  };

  nativeBuildInputs = [p7zip xar cpio];

  unpackCmd = ''
    7z x "$src"
    cd DNGConverter_16_4
    xar -x -f DNGConverter_16_4.pkg
    cd CameraRawProfiles.pkg
    gzip -d < Payload | cpio --extract
  '';

  sourceRoot = "/build/DNGConverter_16_4/CameraRawProfiles.pkg";

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share
    cp -a CameraProfiles $out/share/
    cp -a LensProfiles $out/share/
  '';
}
