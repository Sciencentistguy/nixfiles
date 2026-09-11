# {
  # linuxPackagesFor,
  # linuxKernel,
  # llvmPackages,
  # lib,
  # lld,
  # llvm,
# }: arch:
# linuxPackagesFor (
  # linuxKernel.kernels.linux_latest.override {
    # argsOverride = rec {
      # stdenv =
        # llvmPackages
        # // {
          # stdenv =
            # llvmPackages.stdenv
            # // {
              # mkDerivation = attrs:
                # (llvmPackages.stdenv.mkDerivation attrs).overrideAttrs (this: {
                  # env =
                    # (this.env or {})
                    # // {
                      # # Fix `--target` spam.
                      # NIX_CC_WRAPPER_SUPPRESS_TARGET_WARNING = 1;
                      # # Fix `-nostdinc` warnings.
                      # NIX_CFLAGS_COMPILE = lib.concatStringsSep " " [
                        # (this.env.NIX_CFLAGS_COMPILE or "")
                        # "-Wno-unused-command-line-argument"
                      # ];
                    # };
                # });
            # };
        # }.stdenv;

      # extraMakeFlags = [
        # "LLVM=1"
        # "CC=${llvmPackages.clang}/bin/clang"
        # "LD=${lld}/bin/ld.lld"
        # "AR=${llvm}/bin/llvm-ar"
        # "NM=${llvm}/bin/llvm-nm"
        # "HOSTCC=${llvmPackages.clang}/bin/clang"
        # "HOSTCXX=${llvmPackages.clang}/bin/clang++"
        # "HOSTLD=${lld}/bin/ld.lld"
        # "HOSTAR=${llvm}/bin/llvm-ar"
        # "KCFLAGS+=-march=${arch}"
        # "KCFLAGS+=-flto=thin"
        # "KCXXFLAGS+=-march=${arch}"
        # "KCXXFLAGS+=-flto=thin"
      # ];
      # ignoreConfigErrors = true;
      # structuredExtraConfig = with lib.kernel; {
        # LTO_CLANG_THIN = lib.mkForce yes;
      # };
    # };
  # }
# )
{
  linuxPackagesFor,
  linuxKernel,
  llvmPackages,
  lib,
  lld,
  llvm,
  pkg-config,
  openssl,
  elfutils, # Added elfutils here
}: arch:
linuxPackagesFor (
  (linuxKernel.kernels.linux_latest.override {
    stdenv = llvmPackages.stdenv;
    ignoreConfigErrors = true;
    structuredExtraConfig = with lib.kernel; {
      LTO_CLANG_THIN = lib.mkForce yes;
    };
  }).overrideAttrs (old: {
    nativeBuildInputs = (old.nativeBuildInputs or []) ++ [
      lld
      llvm
      pkg-config
      openssl
      elfutils
    ];

    # Expand library path to include both openssl and elfutils
    env = (old.env or {}) // {
      LD_LIBRARY_PATH = "${lib.makeLibraryPath [ openssl elfutils ]}";
    };

    makeFlags = (old.makeFlags or []) ++ [
      "LLVM=1"
      "LLVM_IAS=1"
      "HOSTLDFLAGS="
      "KCFLAGS+=-march=${arch}"
      "KCXXFLAGS+=-march=${arch}"
    ];
  })
)

