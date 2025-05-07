{ pkgs, ... }: 
let
  theme = import ../../../../theme;
in
{
  home.packages = [ pkgs.libnotify ];
  services.mako = {
    enable = true;

    settings = {
      sort="-time";
      layer="overlay";
      anchor = "top-center";
      default-timeout = 5000; # ms
      ignore-timeout = true;

      # Formatting
      width = 500;
      height = 200;
      margin = "10";
      padding = "15";
      background-color = "#${theme.colors.notifications.background}CC";
      text-color = "#${theme.colors.notifications.foreground}FF";
      max-icon-size = 128;

      # Border
      border-color = null;
      border-radius = 5;
      border-size = 0;

      on-button-left = "dismiss";
      on-button-right = "invoke-default-action";

      # "urgency=low" = {
      #   background-color = "#${theme.colors.notifications.background}66";
      #   default-timeout = 1500;
      # };
      #
      # "urgency=critical" = {
      #   background-color = "#${theme.colors.error}FF";
      #   border-size = 2;
      # };
      #
      # "category=mpd" = {
      #   default-timeout = 2000;
      #   group-by = "category";
      # };
    };
  };
}
