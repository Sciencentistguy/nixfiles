{plex-mpv-shim}:
plex-mpv-shim.overrideAttrs (oldAttrs: {
  postInstall =
    (oldAttrs.postInstall or "")
    + ''
      mkdir -p $out/share/applications
      cat > $out/share/applications/plex-mpv-shim.desktop <<EOF
      [Desktop Entry]
      Type=Application
      Exec=$out/bin/plex-mpv-shim
      Hidden=false
      NoDisplay=false
      X-GNOME-Autostart-enabled=true
      Name=Plex MPV Shim
      Comment=Start Plex MPV Shim on login
      EOF
    '';
})
