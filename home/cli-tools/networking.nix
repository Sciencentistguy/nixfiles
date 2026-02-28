{pkgs, ...}: {
  home.packages = with pkgs; [
    ookla-speedtest
    dig
  ];
}
