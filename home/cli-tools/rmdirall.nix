{flakePkgs, ...}: {
  home.packages = with flakePkgs; [rmdirall];
}
