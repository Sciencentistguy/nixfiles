{
  stdenv,
  makeWrapper,
}:
stdenv.mkDerivation {
  name = "mount-nfs";
  src = ./mount-nfs.sh;
  dontUnpack = true;
  dontBuild = true;
  buildInputs = [makeWrapper];
  installPhase = ''
    install -Dm755 $src $out/bin/mount-nfs.sh
  '';
}
