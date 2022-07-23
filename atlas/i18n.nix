{pkgs, ...}: {
  i18n.defaultLocale = "en_GB.UTF-8";
  console.useXkbConfig = true; # use xkbOptions in tty.
}
