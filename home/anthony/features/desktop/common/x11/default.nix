{ pkgs, ... }: {
  imports = [
    ./alacritty.nix
    ./albert.nix
    ./dunst.nix
    ./picom.nix
    ./rofi.nix
  ];

  home.packages = with pkgs; [
    pipewire
    wireplumber
    flameshot
    xclip
  ];
}
