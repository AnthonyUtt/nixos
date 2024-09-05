{ inputs, outputs, pkgs, config, lib, ... }: {
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
      inputs.hyprwm-contrib.packages.${pkgs.stdenv.hostPlatform.system}.grimblast
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
      egl-wayland
    ];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    plugins = [
      # inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
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
