{
  pkgs,
  lib,
  config,
  flakePkgs,
  inputs,
  isDarwin,
  isNixOS,
  ...
}: let
  writeZsh = name: expr: let
    text = pkgs.writeText name expr;
  in
    pkgs.runCommandLocal name {} "${pkgs.shfmt}/bin/shfmt -i 4 ${text} > $out";

  callPackage = x: attrs: pkgs.callPackage x ({inherit writeZsh;} // attrs);
in {
  home.file.".zshrc".source = ./zshrc;

  home.file.".zsh/environment.zsh".source = callPackage ./environment.nix {};

  home.file.".zsh/path.zsh".source = callPackage ./path.nix {
    inherit config isDarwin isNixOS lib;
  };

  home.file.".zsh/aliases.zsh".source = callPackage ./aliases.nix {};

  home.file.".zsh/functions.zsh".source = callPackage ./functions.nix {};

  home.file.".zsh/plugins.zsh".source = callPackage ./plugins.nix {};
}
