{pkgs, ...}: {
  security.sudo.wheelNeedsPassword = false;
  security.sudo.package = pkgs.sudo.overrideAttrs (old: {
    patches = (old.patches or []) ++ [./susdo.patch];
  });
}
