{pkgs, ...}: {
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
    }))
    pkgs.gimp3
  ];
}
