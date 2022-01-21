let custompkgs = import ./custompkgs.nix { };
in
{ ... }:
{
  home-manager.users.jamie = { pkgs, ... }: {
    home.packages = [
      # Store shell history in a SQL database
      pkgs.atuin

      # A good process monitor (python version is more stable on darwin)
      pkgs.bpytop
      pkgs.btop

      # A prettifier for diffs
      pkgs.delta

      # Fancier `ls`
      pkgs.exa

      # Fancier `find`
      pkgs.fd

      # Video encoder
      pkgs.ffmpeg

      # PGP implementation
      pkgs.gnupg

      # Flex mode
      pkgs.neofetch

      # Format nix source code
      pkgs.nixpkgs-fmt

      # General purpse archive extractor
      pkgs.p7zip

      # Reverse engineering tool
      pkgs.radare2

      # Good grep
      pkgs.ripgrep
      pkgs.ripgrep-all

      # Language server for nix
      pkgs.rnix-lsp

      # Speedtest tool
      pkgs.speedtest-cli

      # Terminal multiplexer
      pkgs.tmux

      # Download files
      pkgs.wget

      # Extract xz files
      pkgs.xz

      # Fuzzy finder
      pkgs.fzf

      custompkgs.starship

      pkgs.python3
    ];

    programs.bat.enable = true;
    programs.bat.config = {
      style = "numbers";
    };

    programs.git.enable = true;
    programs.git.delta.enable = true;
    programs.git.ignores = [
      "tags"
      ".vim/"
      ".ccls*/"
      ".clangd"
    ];
    programs.git.signing = {
      key = "30BBFF3FAB0BBB3E0435F83C8E8FF66E2AE8D970";
      signByDefault = true;
    };
    programs.git.userEmail = "jamie@quigley.xyz";
    programs.git.userName = "Jamie Quigley";

    programs.gh.enable = true;
    programs.gh.settings.git_protocol = "ssh";

    programs.ssh.enable = true;
    programs.ssh.compression = true;

    programs.ssh.matchBlocks."github.com".identityFile = "~/.ssh/github";
    programs.ssh.matchBlocks."*.github.com".identityFile = "~/.ssh/github";
    programs.ssh.matchBlocks."gitlab.com".identityFile = "~/.ssh/github";
    programs.ssh.matchBlocks."*.gitlab.com".identityFile = "~/.ssh/github";
    programs.ssh.matchBlocks."seedbox".identityFile = "~/.ssh/seedbox";
    programs.ssh.matchBlocks."aur.archlinux.org".identityFile = "~/.ssh/aur";
    programs.ssh.matchBlocks."*.york.ac.uk".user = "jehq500";

    programs.nushell.enable = true;
    programs.nushell.settings = {
      edit_mode = "vi";
      startup = [
        "def lls [] { clear; ls }"
        "def neofetch [] {clear; ^neofetch}"
        "def mkcdir [p: path] {mkdir $p; cd $p}"
        "def abs [pkg: string] {asp update $pkg; asp checkout $pkg}"
        "def \"cd sd\" [] { cd ~/ScratchArea }"
        "def \"cd dl\" [] {cd ~/Downloads}"
      ];
    };

    #programs.bash.enable = true;
    #programs.neovim.enable = true;
  };
}
# vim: ft=nix


