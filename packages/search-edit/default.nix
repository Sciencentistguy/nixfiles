{
  fetchgit,
  fzf,
  lib,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation {
  name = "search-edit.sh";

  src = fetchgit {
    url = "https://gist.github.com/0bc58405b9f37dcbc544a5f879d3ff91.git";
    rev = "be131a1ffe972f22016906f256ea86f26c38e653";
    sha256 = "sha256-s0zWfmwLYDkrkB3/k/111YDdmjFuvSLHm+jkrnmp9V8=";
  };

  dontConfigure = true;
  dontBuild = true;

  prePatch = ''
    substituteInPlace search-edit.sh --replace "fzf" "${fzf}/bin/fzf"
  '';

  installPhase = ''
    install -Dm755 search-edit.sh $out/bin/search-edit
  '';

  meta = with lib; {
    description = "A script to interactively find a file, and open it in an editor";
    license = licenses.mpl20;
  };
}
