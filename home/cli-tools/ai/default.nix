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

  # nixpkgs omits pi-schema from the workspace packages copied into the output,
  # which breaks background workflow children.
  pi-coding-agent = pkgs.pi-coding-agent.overrideAttrs (old: let
    anchor = "@earendil-works/pi-mcp:packages/mcp \\\n";
    fixed = lib.hasInfix "@earendil-works/pi-schema:" old.postInstall;
  in {
    postInstall =
      if fixed
      then old.postInstall
      else if lib.hasInfix anchor old.postInstall
      then lib.replaceStrings [anchor] [(anchor + "              @earendil-works/pi-schema:packages/schema \\\n")] old.postInstall
      else throw "pi-coding-agent: postInstall changed upstream; revisit the pi-schema override";
  });
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
      inherit (pi-coding-agent) name version meta;
      paths = [pi-coding-agent];
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
