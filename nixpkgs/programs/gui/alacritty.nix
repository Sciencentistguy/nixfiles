{ pkgs, ... }: {
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    env = { TERM = "alacritty"; };
    window = {
      dynamic_title = false;
      opacity = 0.85;
      title = "Terminal";
      dimensions = {
        columns = 125;
        lines = 35;
      };
    };
    scrolling = {
      history = 100000;
      multiplier = 3;
    };
    font = {
      normal = {
        family = "Iosevka Term";
      };
      size = 14;
    };
    colors = {
      primary = {
        background = "#000000";
        foreground = "#abb2bf";
      };
      cursor = {
        text = "#000000";
        cursor = "#ffffff";
        };
        selection = {
          text = "#eaeaea";
          background = "#404040";

        };
        normal = {
          black = "#282c34";
          red = "#be5046";
          green = "#98c379";
          yellow = "#e5c07b";
          blue = "#61afef";
          magenta = "#c678dd";
          cyan = "#56b6c2";
          white = "#abb2bf";
        };
        bright = {
          black = "#4b5263";
          red = "#bf2e21";
          green = "#80c251";
          yellow = "#e6b04e";
          blue = "#329af0";
          magenta = "#bc4bde";
          cyan = "#56b6c2";
          white = "#ccd0d8";
        };
      };
    };
  }
