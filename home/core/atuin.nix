{
  lib,
  pkgs,
  systemName,
  ...
}: {
  programs.atuin =
    {
      enable = true;
      settings = {
        dialect = "uk";
        auto_sync = true;
        sync_address = "https://api.atuin.sh";
        search_mode = "fulltext";
        threads = {
                    capture = true;
        };
      };
      daemon.enable = true;
    }
    // lib.optionalAttrs (systemName == "discordia") {
      # atuin's e2e tests fail reliably on unsandboxed darwin builds (they
      # start an interactive bash that ends up fighting nix-darwin's
      # /etc/bashrc over PATH). Just skip the test suite.
      package = pkgs.atuin.overrideAttrs (_: {
        doCheck = false;
      });
    };
}
