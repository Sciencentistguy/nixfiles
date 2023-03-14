{
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule {
  pname = "prometheus-awair-exporter";
  version = "unstable-2022-04-08";
  src = fetchFromGitHub {
    # https://github.com/barrucadu/prometheus-awair-exporter
    owner = "barrucadu";
    repo = "prometheus-awair-exporter";
    rev = "f154bbdc401886a1311d80d19d4461a0915ed310";
    sha256 = "sha256-wyBWBfd6r5a4MbiDHYUiMm+JJYRrfD4KFVSgCh/SHqA=";
  };
  vendorSha256 = "sha256-tPdKG26/Hlf2K58b2b3wO4FlaLehxTCk+qpBGN3/od8=";
}
