{
  pkgs,
  flakePkgs,
  ...
}: {
  fonts.packages = with pkgs;
    [
      corefonts
      carlito
      noto-fonts

      flakePkgs.otf-apple
      flakePkgs.ttf-ms-win11
    ]
    ++ (with pkgs.nerd-fonts; [
      iosevka
      iosevka-term
      inconsolata
    ]);
  fonts.fontDir.enable = true;
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = ["Iosevka"];
    };
  };
}
