{pkgs, ...}: let
  # Rawspeed is effectively unmaintained
  # See: https://github.com/darktable-org/rawspeed/pull/972#issuecomment-4820206677
  rawspeedPatches = [
    # rawspeed: Add JPEG XL (DNG 1.7 / Compression 52546) decompressor
    (pkgs.fetchpatch {
      url = "https://github.com/darktable-org/rawspeed/compare/7cf3dc3b9d9c82b414198b1f57460478be6c6c9d...32426848594eafd679c38e26cfe60909dd835816.diff";
      hash = "sha256-UM6Wd1mKqZozarOhaH86ibX/WcwNSqK5hALjnweIU/A=";
      excludes = [".github/*" ".ci/*" "README.rst"];
    })
    # rawspeed: LJpeg: support predictor modes 2-7
    (pkgs.fetchpatch {
      url = "https://github.com/darktable-org/rawspeed/compare/c835b05aecfacb7343f7c424abd620aa12116c3f...5fb229779726aa45d76277f7b9c5c84f5d4183d4.diff";
      hash = "sha256-7jDrIX3SxIVBcpX8yYQYSEgsUvYrDzKe4ffiNSY/sEQ=";
    })
  ];
in {
  home.packages = [
    ((pkgs.darktable.override {withAi = true;}).overrideAttrs (old: {
      patches =
        (old.patches or [])
        ++ [
          # lightroom: import into current modules and params versions
          (pkgs.fetchpatch {
            url = "https://github.com/darktable-org/darktable/compare/fa09a49446e75e9d4a9841f0cfeb9a0b99cc7d77...1ff468b385fbe2220d2140681a5a3411fb527e3a.patch";
            hash = "sha256-zZaHxDRVkRtbOoeCnY7JVix9G3DYWFjmEFlP1/CRBFc=";
            excludes = ["RELEASE_NOTES.md"];
          })
        ];
      # rawspeed is vendored in a subdirectory, so its patches need their own strip root
      postPatch =
        (old.postPatch or "")
        + pkgs.lib.concatMapStrings (p: ''
          patch -p1 -d src/external/rawspeed < ${p}
        '')
        rawspeedPatches;
    }))
    pkgs.gimp3
  ];
}
