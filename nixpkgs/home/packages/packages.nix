{ pkgs, overrides, ... }: {
  home.packages = [
    pkgs.atuin # Store shell history in a SQL database
    pkgs.delta # A prettifier for diffs
    pkgs.fd # Fancier `find`
    pkgs.fzf # Fuzzy finder
    pkgs.gnupg # PGP implementation
    pkgs.neofetch # Flex mode
    pkgs.nixpkgs-fmt # Format nix source code
    pkgs.nushell # Functional shell
    pkgs.p7zip # General purpse archive extractor
    pkgs.pandoc # Convert documents between formats
    pkgs.procs # Fancier `ps`
    pkgs.radare2 # Reverse engineering tool
    pkgs.ripgrep # Faster grep
    pkgs.ripgrep-all # rg through not just text
    pkgs.sad # Modern `sed` replacement
    pkgs.speedtest-cli # Speedtest tool
    pkgs.tmux # Terminal multiplexer
    pkgs.watch # Monitor the output of a command
    pkgs.wget # Download files
    pkgs.xz # Extract xz files
    pkgs.yt-dlp # Download internet videos
    pkgs.coreutils # macOS defaults are woefully out of date

    # Overrides from custompkgs
    pkgs.shark-radar # Check blåhaj stock
    pkgs.starship # Nice prompt
  ];
}
