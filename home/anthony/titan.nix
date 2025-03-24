let
  wallpapers = import ./wallpapers;
in
{
  imports = [
    ./global
    ./global/workstation.nix

    ./features/desktop/common
    ./features/desktop/hyprland

    ./features/games/lutris.nix
    ./features/games/bottles.nix
    ./features/games/steam.nix
    ./features/3d-printing.nix
  ];

  isWorkstation = true;
  wallpaper = wallpapers._32x9.fantasy-forest-floor;
  wallustPalette = "harddark16";
  primaryNetworkInterface = "enp7s0";

  waybar = {
    showBluetooth = false;
    cpuSensorName = "asusec-isa-0000";
  };

  hyprland = {
    env = ''
      env = LIBVA_DRIVER_NAME,nvidia
      env = XDG_SESSION_TYPE,wayland
      env = GBM_BACKEND,nvidia-drm
      # env = ELECTRON_OZONE_PLATFORM_HINT,auto
    '';
    general = ''
      layout=master
    '';
    bindings = ''
      bind=SUPER,t,layoutmsg,swapwithmaster auto
      bind=SUPERSHIFT,t,layoutmsg,focusmaster auto
      bind=SUPER,n,exec,$HOME/.config/hyprland-fzfify/new-workspace
      bind=SUPERSHIFT,n,exec,$HOME/.config/hyprland-fzfify/rename-workspace
      bind=SUPER,w,exec,$HOME/.config/hyprland-fzfify/move-to-workspace
      bind=SUPERSHIFT,w,exec,$HOME/.config/hyprland-fzfify/move-window-to-workspace
    '';
    startup = ''
      exec-once=pactl load-module module-combine-sink
    '';
  };

  monitors = [
    {
      name = "DP-3";
      width = 5120;
      height = 1440;
      refreshRate = 120;
      noBar = false;
      x = 0;
    }
  ];
}
