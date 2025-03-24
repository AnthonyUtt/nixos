{ ... }: {
  imports = [
    # ../features/editors/nvchad
    # ../features/editors/neovim
    ../features/editors/nvim-unmanaged
    ../features/editors/android-studio.nix

    ./modules/waybar.nix
    ./modules/hyprland.nix
    ./modules/interface.nix
    ./modules/monitors.nix
    ./modules/wallpaper.nix
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
  ];
}
