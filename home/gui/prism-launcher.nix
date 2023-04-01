{
  pkgs,
  flakePkgs,
  ...
}: {
  home.packages = let
    prismlauncher = flakePkgs.prismlauncher.override {
      jdks = with pkgs; [jdk8 jdk17 jdk];
    };
  in [prismlauncher];
}
