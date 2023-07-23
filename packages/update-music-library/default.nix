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
    rev = "1a24b23b60d7ff52e6a3a6e07ef6d29bc429e423";
    sha256 = "sha256-IyGbfxa71hHeAQsI+NEns8+OGEyVgYWQTm4PQzYqTGA=";
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
