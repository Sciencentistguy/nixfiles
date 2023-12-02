{
  pkgs,
  flakePkgs,
  ...
}: {
  fonts.packages = with pkgs; [
    corefonts
    carlito
    noto-fonts

    flakePkgs.otf-apple
    flakePkgs.ttf-ms-win11

    (
      nerdfonts.override {
        fonts = ["Iosevka" "IosevkaTerm" "Inconsolata"];
      }
    )
  ];
  fonts.fontDir.enable = true;
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = ["Iosevka"];
    };
  };
}
