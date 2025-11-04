{
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
  version = "1.22.1";

  src = fetchFromGitHub {
    owner = "Sciencentistguy";
    repo = "starship";
    rev = "170a1311d293dbdc26deaec35d0ea097826dab64";
    sha256 = "sha256-QZaLUoxUY+IW9w0+3Mkr6anR/SzmKGs6TkTgLvKqSRA=";
  };

  nativeBuildInputs = [installShellFiles pkg-config cmake git];

  buildInputs = [libgit2];

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

  useFetchCargoVendor = true;

  cargoHash = "sha256-WtfpolAFn/cqEXYy/c4r8CYvwCpfUrL7e03XERQAjkQ=";

  doCheck = false;

  passthru.tests = {
    inherit (nixosTests) starship;
  };

  meta.license = lib.licenses.isc;
}
