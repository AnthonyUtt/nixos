{ pkgs, ... }: {
  programs.rofi = {
    enable = true;
    cycle = true;
    plugins = [];
    terminal = "${pkgs.alacritty}/bin/alacritty";
  };
}
