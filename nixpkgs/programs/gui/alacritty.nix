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
  };

}
