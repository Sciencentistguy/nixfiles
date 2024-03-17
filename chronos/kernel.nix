{config, ...}: {
  boot.extraModulePackages = with config.boot.kernelPackages; [v4l2loopback.out];
  boot.extraModprobeConfig = ''
    option v4l2loopback devices=1 exclusive_caps=1
  '';
  boot.kernelModules = ["sg" "v4l2loopback"];
}
