{pkgs, ...}: {
  # Shadow many macos-provided commands - they're mostly outdated or strange BSD flavoured copies.
  environment.systemPackages = with pkgs; [
    coreutils
    (darwin.shell_cmds.overrideAttrs (old: {meta = old.meta // {priority = 100;};}))
    (
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
  ];
}
