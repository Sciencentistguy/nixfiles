{ pkgs, lib, ... }:
{
  home.packages = lib.optionals (pkgs.stdenv.isLinux) [
    pkgs.drawio # Draw diagrams
    pkgs.gimp # Edit images
    pkgs.gitkraken # Git GUI
    pkgs.jetbrains.idea-community # Java IDE
    pkgs.makemkv # Rip DVDs and Blu-Ray discs
    pkgs.slack # Messaging client
    pkgs.spotify # Music
  ];
}
