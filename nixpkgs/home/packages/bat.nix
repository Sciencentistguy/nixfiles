{ pkgs, ... }:
{
  programs.bat.enable = true;
  programs.bat.config = {
    style = "numbers";
  };
}
