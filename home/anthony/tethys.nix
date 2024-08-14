let
  wallpapers = import ./wallpapers;
in
{
  imports = [
    ./global
    ./global/workstation.nix

    ./features/desktop/common
    ./features/desktop/hyprland
    ./features/desktop/wireless
    ./features/games/steam.nix
  ];

  isWorkstation = true;
  wallpaper = wallpapers._16x10.planet-vector-art;
  wallustPalette = "harddark16";
  primaryNetworkInterface = "wlp0s20f3";

  eww.showBattery = true;

  hyprland = {
    general = "";
    bindings = ''
      bind=SUPER,n,exec,$HOME/.config/hyprland-fzfify/new-workspace
      bind=SUPERSHIFT,n,exec,$HOME/.config/hyprland-fzfify/rename-workspace
      bind=SUPER,w,exec,$HOME/.config/hyprland-fzfify/move-to-workspace
      bind=SUPERSHIFT,w,exec,$HOME/.config/hyprland-fzfify/move-window-to-workspace
    '';
    startup = "";
  };

  monitors = [
    {
      name = "eDP-1";
      width = 1920;
      height = 1200;
      refreshRate = 60;
      noBar = false;
      x = 0;
    }
  ];
}
