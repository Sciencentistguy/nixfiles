{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware.nix

    ./audio.nix
    ./bootloader.nix
    ./docker.nix
    ./filesystems.nix
    ./fonts.nix
    ./gnome
    ./gpg.nix
    ./graphics.nix
    ./i18n.nix
    ./kernel.nix
    ./mouse.nix
    ./networking.nix
    ./nix.nix
    ./steam.nix
    ./sudo.nix
    ./time.nix
    ./vuescan.nix
    ./xone.nix
  ];

  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jamie = {
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  # system-wide text editor
  environment.systemPackages = with pkgs; [vim];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
