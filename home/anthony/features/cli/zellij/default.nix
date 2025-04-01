{ pkgs, ... }: {
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      show_startup_tips = false;
      ui = {
        pane_frames = {
          rounded_corners = true;
          hide_session_name = false;
        };
      };
      theme = "everforest-light";
      themes = {
        bamboo = {
          fg = "#F1E9D2";
          bg = "#252623";
          black = "#5B5E5A";
          red = "#E75A7C";
          green = "#8FB573";
          yellow = "#DBB651";
          blue = "#57A5E5";
          magenta = "#DF73FF";
          cyan = "#70C2BE";
          white = "#FFF8F0";
          orange = "#FF9966";
        };
        everforest-light = {
          fg = "#5C6A72";
          bg = "#FDF6E3";
          black = "#5C6A72";
          red = "#F85552";
          green = "#8DA101";
          yellow = "#DFA000";
          blue = "#3A94C5";
          magenta = "#DF69BA";
          cyan = "#35A77C";
          white = "#E0DCC7";
          orange = "#FF9966";
        };
      };
    };
  };

  xdg.configFile."zellij/layouts" = {
    source = ./layouts;
    recursive = true;
  };
}
