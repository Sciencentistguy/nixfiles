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
    rev = "4284b02032905061c8a348d944608ab6ac9a7882";
    sha256 = "sha256-2XsHL48YnjBjfD+N221W3JabWRsRONvQ3w/u2ISYpG8=";
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
