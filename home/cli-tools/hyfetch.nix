{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [hyfetch];
  home.file.".config/neofetch/config.conf".source = "${inputs.dotfiles}/neofetch.conf";
}
