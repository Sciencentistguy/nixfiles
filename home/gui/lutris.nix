{
  pkgs,
  flakePkgs,
  ...
}: {
  home.packages = let
    lutris = pkgs.lutris.override {
      # For Overwatch 2
      extraLibraries = pkgs: with pkgs; [jansson libunwind];
    };
  in [lutris];
}
