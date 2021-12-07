self: super: {
  beets-with-file-info =
    let
      customPkgs = import
        (fetchTarball {
          url = "https://github.com/Sciencentistguy/nixpkgs/archive/babce8fa33a23bed7a1febf3751b9fca90dc5289.tar.gz";
          sha256 = "1l5zy1ia4vdq5h18xq0mv7hwb0jzs9yifdv2w7iqnjv7d0gabxcj";
        })
        { pkgs = super; };
    in
    super.beets.overrideAttrs (oldAttrs: {
      propagatedBuildInputs = (oldAttrs.propagatedBuildInputs or [ ]) ++ [
        customPkgs.beets-file-info
      ];
    });
}
