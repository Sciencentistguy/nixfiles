{
  fetchFromGitHub,
  buildGoModule,
}:
buildGoModule rec {
  pname = "minecraft-prometheus-exporter";
  version = "0.19.0";
  src = fetchFromGitHub {
    owner = "dirien";
    repo = pname;
    sha256 = "sha256-GVFKGnjZXjjIuTknOTOEmK9Wzilndindtpn0fnntcwM=";
    rev = "v${version}";
  };

  vendorHash = "sha256-M2yhS1s9Sdq9vh7VvrfQLGFfL9DaqCsA3UoeiV5s63g=";
}
