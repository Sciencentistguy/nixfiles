{
  config,
  lib,
  pkgs,
  ...
}: let
  gitSigningEnv = {
    "GIT_CONFIG_COUNT" = "1";
    "GIT_CONFIG_KEY_0" = "user.signingkey";
    "GIT_CONFIG_VALUE_0" = "688D322814AF66F4707E7D3A61DED248F873842E";
  };
in {
  home.file."${config.programs.claude-code.configDir}/keybindings.json".text = builtins.toJSON {
    "$schema" = "https://www.schemastore.org/claude-code-keybindings.json";
    "$docs" = "https://code.claude.com/docs/en/keybindings";
    bindings = [
      {
        context = "Chat";
        bindings.escape = null;
      }
    ];
  };

  programs.claude-code = {
    enable = true;
    package = pkgs.callPackage ./claude-wrapper.nix {};
    context = ./CLAUDE.md;
    mutableSettings = true;
    settings = {
      remoteControlAtStartup = true;
      showThinkingSummaries = true;
      theme = "auto";
      env = gitSigningEnv;
    };
  };

  programs.pi-coding-agent = {
    enable = true;
    package = pkgs.symlinkJoin {
      inherit (pkgs.pi-coding-agent) name version meta;
      paths = [pkgs.pi-coding-agent];
      nativeBuildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/pi \
          ${lib.concatStringsSep " " (lib.mapAttrsToList (name: value: "--set ${name} ${lib.escapeShellArg value}") gitSigningEnv)}
      '';
    };
    extraPackages = import ./runtime-tools.nix pkgs;
    context = ./CLAUDE.md;
  };
}
