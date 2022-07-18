{
  pkgs,
  lib,
  inputs,
  ...
}: {
  programs.bash.enable = true;
  programs.bash.initExtra = let
    # Wow this is cursed. It is not possible to access the contents nixos modules from darwin in a
    # nice way. This works (for now).
    nixos-bash-module = import "${inputs.nixpkgs}/nixos/modules/programs/bash/bash.nix" {
      config = {};
      inherit pkgs lib;
    };
    promptInit = nixos-bash-module.options.programs.bash.promptInit.default;
  in
    promptInit;
}
