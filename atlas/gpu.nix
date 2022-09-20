{pkgs, ...}: {
  services.xserver.videoDrivers = ["nvidia"];

  environment.systemPackages = with pkgs; [nvtop cudatoolkit];

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      intel-media-driver
      vaapiVdpau
      libvdpau
    ];
  };
}
