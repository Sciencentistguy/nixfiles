{
  stdenvNoCC,
  fetchFromGitHub,
  bash,
  gawk,
  git,
  jq,
  libarchive,
  m4,
  asciidoc,
  lib,
}:
stdenvNoCC.mkDerivation rec {
  pname = "asp";
  version = "8";
  src = fetchFromGitHub {
    owner = "falconindy";
    repo = "asp";
    rev = "v${version}";
    sha256 = "sha256-UuWdWu+tBLm/Tf4gC0UUcVcx3vQ+Gp359U+qV8CAH54=";
  };

  buildInputs = [
    bash
    gawk
    git
    jq
    libarchive
    m4
  ];
  nativeBuildInputs = [asciidoc];

  installPhase = ''
    install -Dm755 asp $out/bin/asp
    install -Dm644 man/asp.1 $out/man/asp.1
  '';

  meta = with lib; {
    description = "Arch Build Source Management Tool";
    license = licenses.mit;
    homepage = "https://github.com/archlinux/asp";
  };
}
