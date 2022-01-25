{ config, pkgs, ... }:


let
  custompkgs = pkgs.callPackage /home/jamie/Git/custompkgs { };
  neovim-nightly-pkgs = pkgs.callPackage
    (import
      (builtins.fetchTarball {
        url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
      })
      { }
    )
    { inherit (pkgs) system; };
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "jamie";
  home.homeDirectory = "/home/jamie";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

} // import ./jamie.nix {
  inherit custompkgs pkgs neovim-nightly-pkgs;
  inherit (pkgs) lib;
  isDarwin = false;
}
