{
  fetchgit,
  hostname,
  lib,
  makeWrapper,
  openssh,
  rsync,
  stdenvNoCC,
  tailscale,
}:
stdenvNoCC.mkDerivation {
  name = "update-music-library.sh";

  src = fetchgit {
    url = "https://gist.github.com/159dd62ef4a2ed1886420ebc04b27dbe.git";
    rev = "21c061a526f14ce40ab4eb2dedd95a1a8a673733";
    sha256 = "sha256-En3MAqtxrrnYd9aAobp4rFLtqYAkfeTM/+KdefbvDCo=";
  };

  nativeBuildInputs = [makeWrapper];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    install -Dm755 update-music-library.sh $out/bin/update-music-library
  '';

  postFixup = ''
    wrapProgram $out/bin/update-music-library \
      --set PATH ${lib.makeBinPath [hostname openssh rsync tailscale]}
  '';

  meta = with lib; {
    description = "A script to sync my music library from my desktop PC to my server, using tailscale and rsync";
    license = licenses.mpl20;
  };
}
