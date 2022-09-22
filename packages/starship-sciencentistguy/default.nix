{
  Cocoa,
  Foundation,
  Security,
  cmake,
  fetchFromGitHub,
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
  version = "1.10.1-unstable-2022-09-22";

  src = fetchFromGitHub {
    owner = "Sciencentistguy";
    repo = "starship";
    rev = "90033526949c92225114ead106857d76432eceab";
    sha256 = "sha256-rgVU9REpVfFznLfm6iI6Zh/qC+tWt1LEC9n0dM1uYuQ=";
  };

  nativeBuildInputs = [installShellFiles pkg-config cmake];

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

  cargoSha256 = "sha256-JOkSCVZ1rpl68yrTfYLRm3e4YQvCxeuWFeaJE4uJoIM=";

  preCheck = ''
    HOME=$TMPDIR
  '';

  passthru.tests = {
    inherit (nixosTests) starship;
  };

  meta.license = lib.licenses.isc;
}
