{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  installShellFiles,
  libiconv,
  libgit2,
  pkg-config,
  nixosTests,
  Security,
  Foundation,
  Cocoa,
}:
rustPlatform.buildRustPackage rec {
  pname = "starship";
  version = "1.6.3-scincentistguy";

  src = fetchFromGitHub {
    owner = "Sciencentistguy";
    repo = pname;
    rev = "4b530cef1ee3f26800479855bff886679a9d61ff";
    sha256 = "sha256-2yaxHHOghje0X/sT3G4rrSO3Bskx+cAFgXycC24nPUQ=";
  };

  nativeBuildInputs = [installShellFiles pkg-config];

  buildInputs = [libgit2] ++ lib.optionals stdenv.isDarwin [libiconv Security Foundation Cocoa];

  postInstall = ''
    for shell in bash fish zsh; do
      STARSHIP_CACHE=$TMPDIR $out/bin/starship completions $shell > starship.$shell
      installShellCompletion starship.$shell
    done
  '';

  buildNoDefaultFeatures = true;
  # the "notify" feature is currently broken on darwin
  buildFeatures =
    if stdenv.isDarwin
    then ["battery"]
    else ["default"];

  cargoSha256 = "sha256-e9bcCTiftveg8+LNYPl5dSzJ7CUhxxtrIOlgr5+FN6k=";

  preCheck = ''
    HOME=$TMPDIR
  '';

  passthru.tests = {
    inherit (nixosTests) starship;
  };

  meta.license = lib.licenses.isc;
}
