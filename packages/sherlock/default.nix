{
  fetchFromGitHub,
  lib,
  python3,
  stdenv,
  writeTextFile,
}: let
  python = python3.withPackages (pp: with pp; [requests requests-futures torrequest colorama]);
in
  stdenv.mkDerivation {
    pname = "sherlock";
    version = "unstable-2022-06-04";
    src = fetchFromGitHub {
      owner = "sherlock-project";
      repo = "sherlock";
      rev = "9db8c213ffdad873380c9de41c142923ba0dc260";
      sha256 = "sha256-0/toTz5qLedWdXfh80j6yxH3iXGxboys6mKOjka/nUQ=";
    };

    dontConfigure = true;
    dontBuild = true;

    installPhase = let
      wrapperScript = writeTextFile {
        name = "sherlock-wrapper";
        executable = true;
        text = ''
          #!${stdenv.shell}
          ${python}/bin/python __SHERLOCK__/share/sherlock $@
        '';
      };
    in ''
      mkdir -p $out/{share,bin}
      cp -a sherlock $out/share/
      install -Dm755 ${wrapperScript} $out/bin/sherlock
      substituteInPlace $out/bin/sherlock --replace "__SHERLOCK__" $out
      chmod 755 $out/bin/sherlock
    '';

    meta = with lib; {
      description = "🔎 Hunt down social media accounts by username across social networks";
      license = licenses.mit;
      homepage = "https://github.com/sherlock-project/sherlock";
    };
  }
