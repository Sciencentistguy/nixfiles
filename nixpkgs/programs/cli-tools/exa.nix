{ pkgs, isDarwin, ... }:
let exa =
  in {
    home.packages = with pkgs; [
      exa
    ];
  }
