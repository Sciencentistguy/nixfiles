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
  version = "1.7.1-scincentistguy";

  src = fetchFromGitHub {
    owner = "Sciencentistguy";
    repo = pname;
    rev = "4bef24418e70db8fda6286c397d07b3587bf67de";
    sha256 = "sha256-7qlpZgClqjID+8JovEFUa6sctPe1aDR2c0MTppwhnEY=";
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

  cargoSha256 = "sha256-7lk8RHtS6TYjk+NSi3E9YG/HD4t5VpXRFXXNxgvc2Jg=";

  preCheck = ''
    HOME=$TMPDIR
  '';

  passthru.tests = {
    inherit (nixosTests) starship;
  };

  meta.license = lib.licenses.isc;
}
