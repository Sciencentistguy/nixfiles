{ pkgs, lib, ... }:
let
  top =
    if pkgs.stdenv.isDarwin then
      pkgs.bpytop.overrideAttrs
        (old: {
          postInstall = ''
            ln -s $out/bin/btop $out/bin/bpytop
          '';
        })
    else pkgs.btop;

  ffmpeg = pkgs.ffmpeg-full.override {
    nonfreeLicensing = true;
    fdkaacExtlib = true;
  };

  # bundle beets with a custom plugin
  beets-with-file-info =
    pkgs.beets.overrideAttrs (oldAttrs: {
      propagatedBuildInputs = (oldAttrs.propagatedBuildInputs or [ ]) ++ [
        pkgs.beets-file-info
      ];
    });

  # replace the default error messages in openssh with a suspicious character
  openssh-patched =
    pkgs.openssh.overrideAttrs (oldAttrs:
      {
        patches = oldAttrs.patches or [ ] ++ [
          (pkgs.fetchpatch {
            url = "https://gist.githubusercontent.com/Sciencentistguy/18f94bde5ce06b63d760a736322b1aa0/raw/be75bcf34fe98fd49a68d2fccf366c5e51c06915/sussh.patch";
            sha256 = "sha256-PKrlujoTkvTDCl02AGR5vmlZVeSoLYZqQGERc1sI+hM";
          })
        ];
        dontCheck = true;
        checkTarget = [ ];
      });

  # use a custom colourscheme for exa
  exa-patched = pkgs.exa.overrideAttrs (oldAttrs: {
    patches = oldAttrs.patches or [ ] ++ [
      (pkgs.fetchpatch {
        url = "https://gist.githubusercontent.com/Sciencentistguy/8d48b464d1e5846b55e61854887cc5af/raw/e43d9c4344954b1ae9be9dd0faf1d2e44276ea0f/exa-onedark.patch";
        sha256 = "sha256-JTnumRCJuX6WHcSKBXYCvabDMoKLnBVMqju2TbdEj2E";
      })
    ];
  });
in
{
  home.packages = [
    exa-patched # Fancier `ls`
    ffmpeg # Video encoder. ffmpeg-full doesn't build on darwin
    openssh-patched
    top # Processm monitor
  ] ++ lib.optionals (pkgs.stdenv.isLinux) [
    beets-with-file-info
  ];
}
