### macOS ships a bunch of outdated (or just otherwise *weird*) packages in /bin and /usr/bin
### Theoretically, I'd want to replace all of those with nix packages in environment.systemPackages
{pkgs, ...}: let
  # lib.lowPrio isn't heavy enough - things still clash. This is.
  superLowPrio = x: x.overrideAttrs (old: {meta = old.meta // {priority = 100;};});
in {
  environment.systemPackages = with pkgs; [
    (
      # I don't really want to be dealing with anything from `/bin` if I can help it,
      # but I also don't want to use bsd versions where a gnu-flavoured alternative
      # is available in nixpkgs, hence the low priority.
      superLowPrio darwin.shell_cmds
    )

    # macOS coretuils are BSD flavoured and outdated
    pkgs.coreutils

    (
      # macOS ships a tcsh at `/bin/tcsh` and `/bin/csh`
      tcsh.overrideAttrs (old: {
        postInstall = ''
          ln $out/bin/tcsh $out/bin/csh
        '';
      })
    )

    dash
    ed
    ksh
    pax
    ps

    (
      # macOS places apple-clang stuff everywhere - not just the usual places where you find clang.
      clang.overrideAttrs
      (old: {
        installPhase =
          old.installPhase
          + ''
            ln -s $out/bin/c++ $out/bin/llvm-g++
            ln -s $out/bin/cc $out/bin/llvm-gcc
          '';
      })
    )

    (
      # GCC on macOS? its more likely than you think. See the comment on clang.
      superLowPrio gcc
    )

    # macOS ships with python 3.8 :sob:
    python3

    (
      # `/usr/bin/objdump` etc. Collides with clang, so superLowPrio.
      superLowPrio llvmPackages.bintools
    )

    bzip2
    curl
    diffutils
    findutils
    gawk
    gnugrep
    gnumake
    gzip
    openjdk
    perl
    ruby
    xz
  ];
}
