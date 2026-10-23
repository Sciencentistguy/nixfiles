{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.services.tailscale.enable {
    system.switch.inhibitors.tailscale = config.services.tailscale.package.version;
  };
}
