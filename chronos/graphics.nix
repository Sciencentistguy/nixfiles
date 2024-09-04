{pkgs, ...}: {
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = ["nvidia"];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      intel-media-driver
      vaapiVdpau
      libvdpau
      vulkan-loader
    ];
    extraPackages32 = with pkgs; [
      vulkan-loader
      gst_all_1.gst-libav
    ];
  };

  environment.systemPackages = with pkgs; [nvtopPackages.full];
}
