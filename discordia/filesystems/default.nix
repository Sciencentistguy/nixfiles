{pkgs, ...}: {
  environment.systemPackages = [(pkgs.callPackage ./mount-nfs.nix {})];
}
