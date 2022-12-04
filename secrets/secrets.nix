let
  jamie = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCz1mhcqo+Cl+NvufNP5v37mCsfSgVakDKvO4nI4wD8s4cPNr0f7R9yWPCRDHmWCQTqov+bCrlKOr3o4kA/WVHrl4g8W350b7zb2xmLdm3rg0UqBhY1tasJtoWd55257qBfnieP+9GeVuZG3a7MJD0P1Wi1ZBb0jzw5W+FE8CSSXUbQr/4h/qAe6KezdO1fF4TWIybFTnAXsuvDrUA3XU55Bymld3GuLAlH13DXjEuWs8bhlqUraDTvNM7tgTkR1N7v6IW1FFV8Ulo+9g6rw3WiWykJ6esf0Jmzi4T1W+SGtuP//eecVK58u+R6ut3sbkLXLXf3NsducHDrQypm1zXX";
  chronos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMGhgcvByUqH6DfPij5aZyBJMr9JoFQ0Kg0xRw0eivWA root@nixos";
in {
  "last.fm_password.age".publicKeys = [jamie chronos];
}
