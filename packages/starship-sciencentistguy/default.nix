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
  version = "1.11.0";

  src = fetchFromGitHub {
    owner = "Sciencentistguy";
    repo = "starship";
    rev = "fdb3c56f3d021f76a9a25107e104a1c5b754470e";
    sha256 = "sha256-QFM9mTIRMLjN4qfMwbmiLqiGunSf4hC4tsQPfwMXns0=";
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

  cargoSha256 = "sha256-UeDLVmvIQyJEwCIo8MNyDXCPyqalsvZiMRDiYtNYfnQ=";

  preCheck = ''
    HOME=$TMPDIR
  '';

  passthru.tests = {
    inherit (nixosTests) starship;
  };

  meta.license = lib.licenses.isc;
}
