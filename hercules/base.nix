{
  pkgs,
  modulesPath,
  inputs,
  ...
}: {
  imports = [(modulesPath + "/virtualisation/proxmox-lxc.nix")];

  system.stateVersion = "24.11";
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    sandbox = false;
  };
  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = flakes nix-command
  '';
  nix.nixPath = ["/etc/nix/path"];
  # the version of nixpkgs used to build the system
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  environment.etc."nix/path/nixpkgs".source = inputs.nixpkgs;

  proxmoxLXC = {
    manageNetwork = false;
    privileged = true;
  };

  environment.systemPackages = with pkgs; [alejandra git eza];

  security.pam.services.sshd.allowNullPassword = true;

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
    };
  };
  services.tailscale.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
