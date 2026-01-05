{
  stdenvNoCC,
  appimageTools,
  fetchurl,
  fetchFromGitHub,
  makeDesktopItem,
  copyDesktopItems,
  symlinkJoin,
}: let
  version = "0.7.9.1";
  desktopFile = stdenvNoCC.mkDerivation {
    pname = "helium-desktop";
    inherit version;
    # https://github.com/imputnet/helium-linux
    src = fetchFromGitHub {
      owner = "imputnet";
      repo = "helium-linux";
      rev = version;
      sha256 = "sha256-7bwEawrQWwtQXfg4u1dkJXoex1HE8chwn2FMtPkaidQ=";
    };
    patches = [./desktop.patch];
    dontBuild = true;
    installPhase = ''
      install -Dm644 package/helium.desktop $out/share/applications/helium.desktop
    '';
  };
  helium-bin =
    appimageTools.wrapType2
    rec {
      pname = "helium-bin";
      version = "0.7.9.1";
      src = fetchurl {
        url = "https://github.com/imputnet/helium-linux/releases/download/${version}/helium-${version}-x86_64.AppImage";
        hash = "sha256-69y8dNJPJk+HgnLzkyYLMdps1Med65yeN+77Nk6jbyM=";
      };
      nativeBuildInputs = [copyDesktopItems];
      desktopItems = [
        (makeDesktopItem {
          })
      ];
    };
in
  symlinkJoin {
    inherit (helium-bin) pname version;
    paths = [helium-bin desktopFile];
  }
