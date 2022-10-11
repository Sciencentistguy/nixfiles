# nixfiles

The nix-based configurations for my systems

Currently, this flake describes:

- `chronos`: A desktop PC, running NixOS
- `discordia`: A 2021 MacBook Pro (M1 Max), running macOS and [nix-darwin](https://github.com/LnL7/nix-darwin)
- `atlas`: A server, running NixOS

This flake also outputs some packages that I use in my systems:

- `starship-sciencenitstguy` (https://github.com/Sciencentistguy/starship): A fork of [Starship](https://starship.rs/)
- `shark-radar` (https://git.lavender.software/charlotte/shark-radar): A scraper for blåhaj stock in UK IKEAs.
- `extract`: A bash script to extract many kinds of archive.
- `sherlock` (https://github.com/sherlock-project/sherlock): A program to hunt down social media accounts by username across social networks.
- `otf-apple`: Apple OTF fonts.
- `ttf-ms-win11`: Microsoft TTF fonts.
- `search-edit`: (https://gist.github.com/Sciencentistguy/0bc58405b9f37dcbc544a5f879d3ff91) A script to interactively find a file, and open it in an editor.
- `apple-cursor-theme` (https://github.com/ful1e5/apple_cursor): macOS cursors.
- `update-music-library` (https://gist.github.com/Sciencentistguy/159dd62ef4a2ed1886420ebc04b27dbe): A script to sync my music library from my desktop PC to my server, using tailscale and rsync
- `asp` (https://github.com/falconindy/asp): Archlinux source build tool.

---

All files in this repo, unless stated otherwise, are avaialable under the terms of version 2.0 of the Mozilla Public Licence.
