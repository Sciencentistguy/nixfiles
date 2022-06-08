{
  fetchurl,
  p7zip,
  stdenv,
  lib,
}:
stdenv.mkDerivation {
  pname = "ttf-ms-win11";
  version = "22000.318.211104-1236";

  src = fetchurl {
    url = "https://software-download.microsoft.com/download/sg/888969d5-f34g-4e03-ac9d-1f9786c66749/22000.318.211104-1236.co_release_svc_refresh_CLIENTENTERPRISEEVAL_OEMRET_x64FRE_en-us.iso";
    sha256 = "1djknxnzbdy5f1ig3rdfw6avy8vz70zql58hg0pyz4npvdmc2jv8";
  };

  nativeBuildInputs = [p7zip];

  unpackCmd = ''
    7z x "$src" sources/install.wim
    mkdir source
    pushd source
    7z e ../sources/install.wim Windows/{Fonts/"*".{ttf,ttc},System32/Licenses/neutral/"*"/"*"/license.rtf}
    popd
    rm -rf sources
    pwd
  '';

  dontBuild = true;

  installPhase = ''
    for ttc in *.ttc; do
      install -Dm644 $ttc $out/share/fonts/truetype/$(basename $ttc)
    done

    for ttf in *.ttf; do
      install -Dm644 $ttf $out/share/fonts/truetype/$(basename $ttf)
    done
  '';
  meta.license = lib.licenses.unfree;
}
