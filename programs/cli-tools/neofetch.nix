{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [neofetch];
  home.file.".config/neofetch/config.conf".source = "${inputs.dotfiles}/neofetch.conf";
}
