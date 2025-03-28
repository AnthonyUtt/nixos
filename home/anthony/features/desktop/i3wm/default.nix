{ pkgs, ... }: {
  imports = [
    ../common
    ../common/x11
  ];

  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-rounded;
    config = {
      modifier = "Mod4";
      gaps = {
        inner = 10;
        outer = 5;
      };
    };
  };

  xdg.configFile."i3" = {
    source = ./config;
    recursive = true;
  };

  home.packages = with pkgs; [ i3blocks i3lock ];

  xdg.configFile."i3blocks/config".text = ''
    [click]
    full_text=Click me!
    command=echo "Got clicked with button $button"
    color=#F79494

# Guess the weather hourly
    [weather]
    command=curl -Ss 'https://wttr.in?0&T&Q' | cut -c 16- | head -2 | xargs echo
    interval=3600
    color=#A4C2F4

# Query my default IP address only on startup
    [ip]
    command=hostname -i | awk '{ print "IP:" $1 }'
    interval=once
    color=#91E78B

# Update time every 5 seconds
    [time]
    command=date +%T
    interval=5
  '';
}
