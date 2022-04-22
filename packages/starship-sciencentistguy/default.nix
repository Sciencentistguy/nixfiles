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
  version = "1.5.4-scincentistguy";

  src = fetchFromGitHub {
    owner = "Sciencentistguy";
    repo = pname;
    rev = "422ea6518b3c0d6dfe4239e16e96bb356bdda9d7";
    sha256 = "sha256-8ykmVCeUjFUf/mRLJSOWz5fHtcRy/4Zqe22J7wa6guY=";
  };

  nativeBuildInputs = [installShellFiles pkg-config];

  buildInputs = [libgit2] ++ lib.optionals stdenv.isDarwin [libiconv Security Foundation Cocoa];

  postInstall = ''
    for shell in bash fish zsh; do
      STARSHIP_CACHE=$TMPDIR $out/bin/starship completions $shell > starship.$shell
      installShellCompletion starship.$shell
    done
  '';

  cargoSha256 = "sha256-eR317guD75Lo+CtuRyKv2KHE7FiJyN5XICFCQs0AI2g=";

  preCheck = ''
    HOME=$TMPDIR
  '';

  passthru.tests = {
    inherit (nixosTests) starship;
  };

  meta.license = lib.licenses.isc;
}
