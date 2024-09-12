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
  version = "1.20.1";

  src = fetchFromGitHub {
    owner = "Sciencentistguy";
    repo = "starship";
    rev = "c43f95131debc27e44dc2f555690e7113fe71bf3";
    sha256 = "sha256-70Mja7dBTOl4SoOO68HFKASlludVwFaH3TZEAvvwDq0=";
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

  cargoHash = "sha256-BYtq0C42sUHMufTf7WsG1pGAsfEQg9hRJTgMRfFwgP0=";

  doCheck = false;

  passthru.tests = {
    inherit (nixosTests) starship;
  };

  meta.license = lib.licenses.isc;
}
