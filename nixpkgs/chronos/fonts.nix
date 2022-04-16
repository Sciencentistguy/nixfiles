{pkgs, ...}: {
  fonts.fonts = with pkgs; [
    corefonts
    carlito
    noto-fonts
    (
      nerdfonts.override {
        fonts = ["Iosevka" "Inconsolata"];
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
