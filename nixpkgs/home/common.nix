{ config, pkgs, lib, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
  overrides = pkgs.callPackage ../common/overrides.nix {
    inherit isDarwin;
  };
in
{
  imports = [ ./packages ];
  # home.packages = neovim-with-dependencies ++ lib.optionals (!isDarwin) [ ];

  # Let Home Manager install and manage itself on linux.
  programs.home-manager.enable = !isDarwin;
}

# vim: ft=nix
