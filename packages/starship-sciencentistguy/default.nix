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
  pname = "starship-sciencentistguy";
  version = "1.9.1";

  src = fetchFromGitHub {
    owner = "Sciencentistguy";
    repo = "starship";
    rev = "3d8208cb13f077110a8d3617fc24e967dab41b6b";
    sha256 = "sha256-ibmNVxf37UB9fb2ymT/mglDnNCAwpSZlKp4CVICW1TM=";
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

  cargoSha256 = "sha256-8gmfwvkh6pC3538XXCz+Dvlm3N7MJ4cfyA6oLQL6hvQ=";

  preCheck = ''
    HOME=$TMPDIR
  '';

  passthru.tests = {
    inherit (nixosTests) starship;
  };

  meta.license = lib.licenses.isc;
}
