self: super: rec {
  # ffmpeg full requires an override to enable the (nonfree) libfdk_aac.
  #
  # it also needs a wrapper script to use nvenc on non-nixos systems because it is otherwise unable
  # to find libcuda.so
  #
  # See: https://github.com/NixOS/nixpkgs/issues/77834
  multimc-nixgl =
    let
      nixGLPkgs = import
        (fetchTarball {
          name = "nixGL";
          url = "https://github.com/guibou/nixGL/archive/c4aa5aa15af5d75e2f614a70063a2d341e8e3461.tar.gz";
          sha256 = "09p7pvdlf4sh35d855lgjk6ciapagrhly9fy8bdiswbylnb3pw5d";
        })
        { pkgs = super; };

      multimc-nixgl-patch = builtins.fetchurl {
        url = "https://gist.githubusercontent.com/Sciencentistguy/147a139aeea014c147232fa763d14347/raw/dae7cd95b3d8f9982efd91fa37f05a6a76bd9bd3/multimc-nixgl.patch";
        sha256 = "0l3rms36556xqknm2jnxxfmy4mr5hwhvjvqkkw00jpbabcjl9sys";
      };
    in
    (super.multimc.overrideAttrs (attrs: {
      patches = attrs.patches ++ [
        multimc-nixgl-patch
      ];

      postPatch = attrs.postPatch + ''
        substituteInPlace launcher/package/ubuntu/multimc/opt/multimc/run.sh --replace "@nixgl@" "${nixGLPkgs.auto.nixGLDefault}/bin/nixGL"
      '';

      propogatedBuildInputs = [
        nixGLPkgs.auto.nixGLDefault
      ];
    }));
}
