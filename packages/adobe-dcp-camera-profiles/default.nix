{
  cpio,
  fetchurl,
  libxml2,
  p7zip,
  stdenvNoCC,
  xar,
}:
stdenvNoCC.mkDerivation rec {
  pname = "adobe-dcp-camera-profiles";

  src = fetchurl {
    url = "https://www.adobe.com/go/dng_converter_mac";
    sha256 = "sha256-HYsBz1DeZTMhP4v4n6865RWiL2LUU0PfPGmC2MnAL/M=";
  };

  version = "17_3_1";

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
