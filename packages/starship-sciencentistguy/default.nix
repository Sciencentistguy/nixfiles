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
  version = "1.12.0";

  src = fetchFromGitHub {
    owner = "Sciencentistguy";
    repo = "starship";
    rev = "6c614828088f532e009de8b157819069479a9883";
    sha256 = "sha256-CjshHuBeA3cTP3l38ARi1qmMoDzNfintVYhNIovlYg0=";
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

  cargoSha256 = "sha256-8uXD/5aBI2O1I/rvwk9MgA9J6VO2s1K29heOfmlIFDI=";

  preCheck = ''
    HOME=$TMPDIR
  '';

  passthru.tests = {
    inherit (nixosTests) starship;
  };

  meta.license = lib.licenses.isc;
}
