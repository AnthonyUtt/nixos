{ inputs, outputs, pkgs, config, lib, ... }: 
let
  system = pkgs.stdenv.hostPlatform.system;
in {
  imports = [
    ../common
    ../common/wayland
    inputs.hyprland.homeManagerModules.default

    ./fzfify.nix
  ];

  programs.zsh.loginExtra = ''
    if [ "$(tty)" = "/dev/tty1" ]; then
      exec Hyprland &> /dev/null
    fi
  '';

  programs.zsh.profileExtra = ''
    if [ "$(tty)" = "/dev/tty1" ]; then
      exec Hyprland &> /dev/null
    fi
  '';

  home = {
    sessionVariables = { XDG_CURRENT_DESKTOP = "Hyprland"; };
    packages = with pkgs; [
      inputs.hyprwm-contrib.packages.${system}.grimblast
      xdg-desktop-portal-gtk
      egl-wayland
    ];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${system}.hyprland;
    plugins = with inputs.hyprland-plugins.packages.${system}; [
      xtra-dispatchers
    ];
    extraConfig = let
      theme = import ../../../theme;
    in
      (import ./config.nix {
        inherit (config) home wallpaper hyprland;
        theme = theme;
      }) +
      (import ./monitors.nix {
        inherit lib;
        inherit (config) monitors;
      });
  };
}
