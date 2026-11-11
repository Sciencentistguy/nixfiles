{pkgs, ...}: {
  programs.coolercontrol.enable = true;

  # The H150i Pro controller periodically stops answering USB requests, after which
  # restarting the daemon alone fails with a libusb overflow. Power-cycling the USB
  # device (found by vendor/product id, as the port can change) recovers it, but only
  # while the daemon is stopped: its liquidctl process otherwise talks to the device
  # mid-reset and wedges it again.
  systemd.services.coolercontrold-usb-recovery = {
    description = "Reset the H150i USB device when CoolerControl loses it";
    wantedBy = ["multi-user.target"];
    path = with pkgs; [systemd coreutils gnugrep];
    serviceConfig = {
      Restart = "always";
      RestartSec = 5;
    };
    script = ''
      journalctl --follow --lines=0 --output=cat --unit=coolercontrold |
        grep --line-buffered --extended-regexp "Significant issue retrieving status for liquidctl device: Corsair Hydro|Error getting status from device #[0-9]+: Response timed out|Failed to initialize device 'Corsair Hydro" |
        while read -r _; do
          systemctl stop coolercontrold
          # one stall logs several lines, so drop those queued behind the one we acted on
          while read -r -t 1 _; do :; done
          for dev in /sys/bus/usb/devices/*; do
            [ "$(cat "$dev/idVendor" 2>/dev/null)" = 1b1c ] || continue
            [ "$(cat "$dev/product" 2>/dev/null)" = "H150i Platinum" ] || continue
            echo 0 > "$dev/authorized"
            sleep 2
            echo 1 > "$dev/authorized"
          done
          sleep 5
          systemctl start coolercontrold
          # a failed init is logged by the new daemon and retriggers recovery after this pause
          sleep 30
        done
    '';
  };
}
