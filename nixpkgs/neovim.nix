{ pkgs, overrides }:
[
  overrides.neovim

  (pkgs.python3.withPackages (pythonPackages: with pythonPackages; [ pynvim ]))
  pkgs.nodejs
  pkgs.python3Packages.autopep8
  pkgs.shellcheck
  pkgs.shfmt
  pkgs.stylua
  pkgs.yarn
]
