{stdenvNoCC}:
stdenvNoCC.mkDerivation {
  pname = "vuescan";
  version = "9.8.26";
  src = fetchTarball {
    url = "https://www.hamrick.com/files/vuex6498.tgz";
    sha256 = "12gjjkw3cnn9bfwmn48r3cw73wpbcwpzwwj21s1rdvgsdh0w99dq";
  };
  dontBuild = true;
  installPhase = ''
    install -Dm644 vuescan.svg $out/share/icons/hicolor/scalable.apps/vuescan.svg
    install -Dm644 vuescan.rul $out/lib/udev/rules.d/60-vuescan.rules
    install -Dm755 vuescan $out/bin/vuescan
  '';
}
