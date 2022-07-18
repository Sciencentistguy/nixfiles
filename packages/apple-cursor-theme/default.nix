{
  stdenv,
  fetchFromGitHub,
  lib,
}:
stdenv.mkDerivation rec {
  pname = "apple-cursor-theme";
  version = "1.2.3";

  # Use a pre-built release because building depends on a network connection
  src = fetchTarball {
    url = "https://github.com/ful1e5/apple_cursor/releases/download/v1.2.3/macOSMonterey.tar.gz";
    sha256 = "081p1xaymc68yp8b84mnf6skbplsyxkr013wv7zfbba7rnvqpp7n";
  };

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/icons/macOSMonterey
    cp -a * $out/share/icons/macOSMonterey
  '';

  meta = with lib; {
    description = "macOS cursor theme";
    homepage = "https://github.com/ful1e5/apple_cursor";
    license = with licenses; gpl3Only;
  };
}
