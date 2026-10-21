{
  config,
  flakePkgs,
  lib,
  ...
}: let
  baseKernelPackages = flakePkgs.linuxPackagesForArch "znver2";
in {
  boot.extraModulePackages = with config.boot.kernelPackages; [v4l2loopback.out];
  boot.extraModprobeConfig = ''
    option v4l2loopback devices=1 exclusive_caps=1
  '';
  boot.kernelModules = ["sg" "v4l2loopback"];
  boot.kernelParams = [
    "fastboot"
    "consoleblank=0"
  ];

  # TODO: drop the v4l2loopback override once https://github.com/NixOS/nixpkgs/pull/575861 reaches nixpkgs-unstable.
  # Kernel 7.3 runs depmod in modules_install, so the package ships modules.* files that collide with the kernel's.
  assertions = [
    {
      assertion = !(lib.elem "DEPMOD=true" (baseKernelPackages.v4l2loopback.installFlags or []));
      message = "chronos/kernel.nix: nixpkgs now sets DEPMOD=true for v4l2loopback, remove the modules.* removal override";
    }
  ];

  hardware.xpad-noone.enable = false;

  boot.kernelPackages = baseKernelPackages.extend (final: prev: {
    v4l2loopback = prev.v4l2loopback.overrideAttrs (old: {
      postInstall =
        (old.postInstall or "")
        + ''
          rm -f $out/lib/modules/*/modules.*
        '';
    });
  });
}
