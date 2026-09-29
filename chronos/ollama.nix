{pkgs, ...}: {
  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan;
    host = "0.0.0.0";
    environmentVariables = {
      OLLAMA_CONTEXT_LENGTH = "64000";
      OLLAMA_FLASH_ATTENTION = "1";
      OLLAMA_KV_CACHE_TYPE = "q8_0";
    };
  };
}
