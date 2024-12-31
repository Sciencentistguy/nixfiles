{
  cpio,
  fetchurl,
  libxml2,
  p7zip,
  stdenvNoCC,
  xar,
}:
stdenvNoCC.mkDerivation rec {
  name = "adobe-dcp-camera-profiles";

  src = fetchurl {
    url = "https://www.adobe.com/go/dng_converter_mac";
    sha256 = "sha256-b88CHHYFqgNcaWAsjb+vJXKI/wgzWbhYUGWwsWbNzxk=";
  };

  fileVersion = "16_5";

  nativeBuildInputs = let
    # xar is broken on linux since gcc14. See https://github.com/NixOS/nixpkgs/pull/368920
    xar' = if stdenvNoCC.isLinux then xar.overrideAttrs (old: {
      env.NIX_CFLAGS_COMPILE = toString [
        # libxml2 hack (see nixpkgs)
        "-isystem ${libxml2.dev}/include/libxml2"
        # fix build on GCC 14
        "-Wno-error=implicit-function-declaration"
        "-Wno-error=incompatible-pointer-types"
      ];
    }) else xar;
  in [p7zip xar' cpio];

  unpackCmd = ''
    7z x "$src"
    cd DNGConverter_${fileVersion}
    xar -x -f DNGConverter_${fileVersion}.pkg
    cd CameraRawProfiles.pkg
    gzip -d < Payload | cpio --extract
  '';

  sourceRoot = "/build/DNGConverter_${fileVersion}/CameraRawProfiles.pkg";

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share
    cp -a CameraProfiles $out/share/
    cp -a LensProfiles $out/share/
  '';
}
