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
  version = "1.21.1";

  src = fetchFromGitHub {
    owner = "Sciencentistguy";
    repo = "starship";
    rev = "6f4d0abc6d3ce73bba7cc3669f44cfc0a6a952e6";
    sha256 = "sha256-Yu8R4komg/B+3oZ0A7iYPhZTNEIgaOsHtPhIze6PtHQ=";
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

  preCheck = ''
    HOME=$TMPDIR
  '';

  cargoHash = "sha256-sThc9zyJENkcuPqJ1BKNCx+IPHvvaaf0GJLC6ONjLsI=";

  doCheck = false;

  passthru.tests = {
    inherit (nixosTests) starship;
  };

  meta.license = lib.licenses.isc;
}
