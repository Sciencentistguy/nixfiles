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
  version = "1.10.1";

  src = fetchFromGitHub {
    owner = "Sciencentistguy";
    repo = "starship";
    rev = "bcc4b156327cd7d5a6cc170ee40c8b357640b32f";
    sha256 = "sha256-SSFQlVF0YAYIoogcibQ6cBO9XZcWABKkJw9J6t3eaXQ=";
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

  cargoSha256 = "sha256-3ge+yFo8JmizpBAyeLKo9NuZ5xbar+xS9w4oZ0boJ8c=";

  preCheck = ''
    HOME=$TMPDIR
  '';

  passthru.tests = {
    inherit (nixosTests) starship;
  };

  meta.license = lib.licenses.isc;
}
