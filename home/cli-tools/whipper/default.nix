{pkgs, ...}: {
  home.packages = let
    # Work around https://github.com/whipper-team/whipper/issues/234, as my CD drive is +667
    whipper =
      (pkgs.whipper.overrideAttrs (old: {
        patches = old.patches or [] ++ [./cdparanoia.patch];
      }))
      .override {libcdio-paranoia = pkgs.cdparanoia;};
  in [whipper];
}
