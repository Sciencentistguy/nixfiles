{
  pkgs,
  flakePkgs,
  ...
}: let
  drMeterOnSave = pkgs.runCommand "picard-dr-meter-on-save" {} ''
    mkdir $out
    cp ${./picard-plugins/dr-meter-on-save/MANIFEST.toml} $out/MANIFEST.toml
    substitute ${./picard-plugins/dr-meter-on-save/__init__.py} $out/__init__.py \
      --subst-var-by dr ${flakePkgs.dr-rs}/bin/dr
  '';
in {
  home.packages = with pkgs; [picard];

  xdg.dataFile."MusicBrainz/Picard/plugins3/dr-meter-on-save".source = drMeterOnSave;
}
