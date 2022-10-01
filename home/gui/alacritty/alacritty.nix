{
  alacritty,
  fetchFromGitHub,
  lib,
}:
alacritty.overrideAttrs (old: rec {
  postInstall = builtins.replaceStrings ["io.alacritty"] ["org.alacritty"] old.postInstall;

  patches =
    (old.patches or [])
    ++ [
      ./stfu-alacritty.patch
      ./create-new-window-cwd.patch
    ];
})
