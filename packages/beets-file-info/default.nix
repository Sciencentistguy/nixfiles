{
  beets,
  fetchFromGitHub,
  lib,
  python3Packages,
}:
python3Packages.buildPythonPackage {
  pname = "beets-file-info";
  version = "1.0";
  src = fetchFromGitHub {
    repo = "beets-file-info";
    owner = "Sciencentistguy";
    rev = "1.0";
    sha256 = "sha256-rLrXJ/iMaa+zg7UENffZtSsz74SQ6X/RlIWlR8QPt+M=";
  };
  nativeBuildInputs = [beets];
}
