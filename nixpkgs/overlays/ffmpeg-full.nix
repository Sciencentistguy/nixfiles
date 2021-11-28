self: super: {
  # ffmpeg full requires an override to enable the (nonfree) libfdk_aac.
  #
  # it also needs a wrapper script to use nvenc on non-nixos systems because it is otherwise unable
  # to find libcuda.so
  #
  # See: https://github.com/NixOS/nixpkgs/issues/77834
  ffmpeg-full =
    let
      nixGLPkgs = import
        (fetchTarball {
          name = "nixGL";
          url = "https://github.com/guibou/nixGL/archive/c4aa5aa15af5d75e2f614a70063a2d341e8e3461.tar.gz";
          sha256 = "09p7pvdlf4sh35d855lgjk6ciapagrhly9fy8bdiswbylnb3pw5d";
        })
        { pkgs = super; };
    in
    (super.ffmpeg-full.overrideAttrs (attrs: {
      postInstall = ''
        mv ${placeholder "out"}/bin/ffmpeg ${placeholder "out"}/bin/ffmpeg-bin
        echo 'nixGL ${placeholder "out"}/bin/ffmpeg-bin "$@"' > ${placeholder "out"}/bin/ffmpeg
        chmod 755 ${placeholder "out"}/bin/ffmpeg
      '';

      propogatedBuildInputs = [
        nixGLPkgs.auto.nixGLDefault
      ];

    })).override
      {
        nonfreeLicensing = true;
        fdkaacExtlib = true;
      };
}
