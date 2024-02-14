{
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    alacritty
    mpv
  ];

  system.activationScripts.applications.text = let
    env = pkgs.buildEnv {
      name = "system-applications";
      paths = config.environment.systemPackages;
      pathsToLink = "/Applications";
    };
  in
    pkgs.lib.mkForce ''
      # Set up applications.
      echo "setting up /Applications..." >&2

      rm -rf /Applications/Nix\ Apps
      mkdir -p /Applications/Nix\ Apps

      find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
          while read src; do
            cp -aL "$src" /Applications/Nix\ Apps
          done
    '';
}
