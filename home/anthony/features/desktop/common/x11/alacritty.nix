{ pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;
    theme = "everforest_light";
    settings = {
      window = {
        dimensions = {
          columns = 78;
          lines = 28;
        };
        padding = {
          x = 0;
          y = 0;
        };
        dynamic_padding = true;
      };
      font = {
        size = 11;
        normal = {
          family = "Departure Mono";
          style = "Regular";
        };
        bold = {
          family = "Departure Mono";
          style = "Bold";
        };
        italic = {
          family = "Departure Mono";
          style = "Italic";
        };
        bold_italic = {
          family = "Departure Mono";
          style = "Bold Italic";
        };
      };
      keyboard.bindings = [
        {
          key = "Key0";
          mods = "Control";
          action = "ResetFontSize";
        }
        {
          key = "Equals";
          mods = "Control";
          action = "IncreaseFontSize";
        }
        {
          key = "Minus";
          mods = "Control";
          action = "DecreaseFontSize";
        }
      ];
    };
  };
}
