{pkgs, ...}: {
  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan;
    host = "0.0.0.0";
  };
}
