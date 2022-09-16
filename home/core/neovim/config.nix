{
  src,
  stdenvNoCC,
  zathura,
  shfmt,
  nodePackages,
  rustfmt,
}:
stdenvNoCC.mkDerivation {
  name = ".config/nvim";
  inherit src;

  dontConfigure = true;
  dontBuild = true;

  patchPhase = ''
    # Zathura from nixpkgs
    substituteInPlace nvim/lua/user/vimtex.lua \
     --replace "zathura" "${zathura}" \

    # Formatters from nixpkgs
    substituteInPlace nvim/lua/user/neoformat.lua \
     --replace "exe = \"shfmt\"" "exe = \"${shfmt}/bin/shfmt\"" \

    substituteInPlace nvim/lua/user/neoformat.lua \
     --replace "exe = \"prettier\"" "exe = \"${nodePackages.prettier}/bin/prettier\""

    substituteInPlace nvim/lua/user/neoformat.lua \
     --replace "exe = \"rustfmt\"" "exe = \"${rustfmt}/bin/rustfmt\"" \
  '';

  installPhase = ''
    mkdir -p $out
    cp -a nvim/* $out/
  '';
}
