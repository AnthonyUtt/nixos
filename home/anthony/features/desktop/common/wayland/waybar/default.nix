{ pkgs, ... }: {
  programs.waybar = {
    enable = true;
  };

  home.packages = with pkgs; [
    wttrbar
  ];

  xdg.configFile."waybar" = {
    source = ./config;
    recursive = true;
  };
}
