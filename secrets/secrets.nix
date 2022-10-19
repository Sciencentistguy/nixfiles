let
  key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCz1mhcqo+Cl+NvufNP5v37mCsfSgVakDKvO4nI4wD8s4cPNr0f7R9yWPCRDHmWCQTqov+bCrlKOr3o4kA/WVHrl4g8W350b7zb2xmLdm3rg0UqBhY1tasJtoWd55257qBfnieP+9GeVuZG3a7MJD0P1Wi1ZBb0jzw5W+FE8CSSXUbQr/4h/qAe6KezdO1fF4TWIybFTnAXsuvDrUA3XU55Bymld3GuLAlH13DXjEuWs8bhlqUraDTvNM7tgTkR1N7v6IW1FFV8Ulo+9g6rw3WiWykJ6esf0Jmzi4T1W+SGtuP//eecVK58u+R6ut3sbkLXLXf3NsducHDrQypm1zXX";

  secrets = [
    # "secret1.age"
  ];
in
  builtins.listToAttrs (map (v: {
      name = v;
      value = {publicKeys = [key];};
    })
    secrets)
