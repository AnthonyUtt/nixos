{ pkgs, ... }: {
  services.picom = {
    enable = true;
    package = pkgs.picom-pijulius;

    backend = "glx";
    vSync = true;

    activeOpacity = 1.0;
    inactiveOpacity = 0.7;

    settings = {
      unredir-if-possible = false;
      blur = {
        method = "dual_kawase";
        kernel = 5;
        strength = 7;
        background = true;
      };
    };
  };
}
