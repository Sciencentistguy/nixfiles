{
lib,
stdenv,
  darktable,
  darktable-src,
}:
darktable.overrideAttrs (old: {
  src = darktable-src;
  # dontCheck = true;
  installCheckPhase = ''
    echo skipped...
  '';

    cmakeFlags = old.cmakeFlags ++ (lib.optionals (stdenv.isDarwin) [
        "-DCMAKE_OSX_DEPLOYMENT_TARGET=26"
    ]);
})
