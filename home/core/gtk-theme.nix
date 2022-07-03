{pkgs, ...}: {
  gtk = {
    enable = true;
    cursorTheme.package = pkgs.paper-gtk-theme;
    cursorTheme.name = "Paper";
    theme.package = pkgs.materia-theme;
    theme.name = "Materia-compact";
  };
}
