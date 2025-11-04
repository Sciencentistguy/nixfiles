{
  darktable,
  darktable-src,
}:
darktable.overrideAttrs (_: {
  src = darktable-src;
  # dontCheck = true;
  installCheckPhase = ''
    echo skipped...
  '';
})
