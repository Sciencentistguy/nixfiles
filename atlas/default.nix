{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware.nix

    ./bootloader.nix
    ./filesystems.nix
    ./gpg.nix
    ./i18n.nix
    ./networking.nix
    ./nix.nix
    ./sudo.nix
    ./time.nix
  ];

  programs.zsh.enable = true;

  users.users.jamie = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
  };

  # system-wide text editor
  environment.systemPackages = with pkgs; [vim];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
