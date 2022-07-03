{
  pkgs,
  inputs,
  ...
}: {
  home.file.".ghc/ghci.conf".source = "${inputs.dotfiles}/ghci.conf";
}
