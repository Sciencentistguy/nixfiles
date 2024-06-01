{
  Cocoa,
  Foundation,
  Security,
  cmake,
  fetchFromGitHub,
  git,
  installShellFiles,
  lib,
  libgit2,
  libiconv,
  nixosTests,
  pkg-config,
  rustPlatform,
  stdenv,
}:
rustPlatform.buildRustPackage rec {
  pname = "starship-sciencentistguy";
  version = "1.19.0";

  src = fetchFromGitHub {
    owner = "Sciencentistguy";
    repo = "starship";
    rev = "c371772cf1840b8296be4a1c78ab741be20db937";
    sha256 = "sha256-gLVOhX+LLwoQRgLiSI22Wiw97tUAgEKhd1+nbUVuijw=";
  };

  nativeBuildInputs = [installShellFiles pkg-config cmake git];

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

  cargoSha256 = "sha256-ek190oqgR2Rng6PVisUHWQWLjFLmlFuQivBUEqH8kvA=";

  preCheck = ''
    HOME=$TMPDIR
  '';

  doCheck = false;

  passthru.tests = {
    inherit (nixosTests) starship;
  };

  meta.license = lib.licenses.isc;
}
