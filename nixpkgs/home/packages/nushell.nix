{ pkgs, ... }:
{
  programs.nushell.enable = true;
  programs.nushell.settings = {
    edit_mode = "vi";
    startup = [
      "def lls [] { clear; ls }"
      "def neofetch [] {clear; ^neofetch}"
      "def mkcdir [p: path] {mkdir $p; cd $p}"
      "def abs [pkg: string] {asp update $pkg; asp checkout $pkg}"
      "def \"cd sd\" [] { cd ~/ScratchArea }"
      "def \"cd dl\" [] {cd ~/Downloads}"
    ];
  };
}
