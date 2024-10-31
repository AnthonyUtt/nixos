{ pkgs, ... }: {
  home.packages = [
    # (pkgs.discord.override {
    #   withVencord = true;
    # })
    pkgs.webcord
  ];
  xdg.configFile = {
    "discord/settings.json" = {
      source = ./settings.json;
    };

    "Vencord" = {
      recursive = true;
      source = ./vencord;
    };
  };
}
