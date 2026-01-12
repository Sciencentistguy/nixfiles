{
  linuxPackagesFor,
  linuxKernel,
  llvmPackages,
  lib,
  lld,
  llvm,
}: arch:
linuxPackagesFor (
  linuxKernel.kernels.linux_latest.override {
    argsOverride = rec {
      stdenv =
        llvmPackages
        // {
          stdenv =
            llvmPackages.stdenv
            // {
              mkDerivation = attrs:
                (llvmPackages.stdenv.mkDerivation attrs).overrideAttrs (this: {
                  env =
                    (this.env or {})
                    // {
                      # Fix `--target` spam.
                      NIX_CC_WRAPPER_SUPPRESS_TARGET_WARNING = 1;
                      # Fix `-nostdinc` warnings.
                      NIX_CFLAGS_COMPILE = lib.concatStringsSep " " [
                        (this.env.NIX_CFLAGS_COMPILE or "")
                        "-Wno-unused-command-line-argument"
                      ];
                    };
                });
            };
        }.stdenv;

      extraMakeFlags = [
        "LLVM=1"
        "CC=${llvmPackages.clang}/bin/clang"
        "LD=${lld}/bin/ld.lld"
        "AR=${llvm}/bin/llvm-ar"
        "NM=${llvm}/bin/llvm-nm"
        "KCFLAGS+=-march=${arch}"
        "KCFLAGS+=-flto=thin"
        "KCXXFLAGS+=-march=${arch}"
        "KCXXFLAGS+=-flto=thin"
      ];
      ignoreConfigErrors = true;
      structuredExtraConfig = with lib.kernel; {
        LTO_CLANG_THIN = lib.mkForce yes;
      };
    };
  }
)
