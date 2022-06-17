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
  version = "1.8.0-scincentistguy";

  src = fetchFromGitHub {
    owner = "Sciencentistguy";
    repo = pname;
    rev = "873885b199c36e71a39f8488158ee92a6f93d1c2";
    sha256 = "sha256-e7Vw3GpvR3EHotnbHWC6kbVgmyGV4POlCl9dMXrauu4=";
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

  cargoSha256 = "sha256-KWRpu1AIlHMSzH4m6KaGXZlKYrd5RQKCe4c+PrgoihA=";

  preCheck = ''
    HOME=$TMPDIR
  '';

  passthru.tests = {
    inherit (nixosTests) starship;
  };

  meta.license = lib.licenses.isc;
}
