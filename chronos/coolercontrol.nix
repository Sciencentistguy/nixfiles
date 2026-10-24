{pkgs, ...}: {
  programs.coolercontrol.enable = true;

  # The H150i Pro controller periodically stops answering USB requests, after which
  # restarting the daemon alone fails with a libusb overflow. Power-cycling the USB
  # device (found by vendor/product id, as the port can change) recovers it.
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
        grep --line-buffered "Significant issue retrieving status for liquidctl device: Corsair Hydro" |
        while read -r _; do
          for dev in /sys/bus/usb/devices/*; do
            [ "$(cat "$dev/idVendor" 2>/dev/null)" = 1b1c ] || continue
            [ "$(cat "$dev/product" 2>/dev/null)" = "H150i Platinum" ] || continue
            echo 0 > "$dev/authorized"
            sleep 2
            echo 1 > "$dev/authorized"
          done
          sleep 3
          systemctl restart coolercontrold
        done
    '';
  };
}
