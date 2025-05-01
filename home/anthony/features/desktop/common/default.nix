{ pkgs, ... }: {
  imports = [
    ./chromium.nix
    ./cursor-ide
    ./cursors.nix
    ./discord
    ./firefox
    # ./eww
    ./light.nix
    ./obsidian.nix
    ./pavucontrol.nix
    ./slack.nix
    ./spotify.nix
    # ./vivaldi
    ./wallust
  ];

  xdg.mimeApps.enable = true;

  home.packages = with pkgs; [
    # beekeeper-studio
    dbeaver-bin
    # postman
    remmina
    playerctl
    gimp
    inkscape
    # figma-linux
    libsForQt5.dolphin
    brightnessctl
    thunderbird
    libation
    # cozy
    vlc
    windsurf

    aider-chat
    codex
  ];

  # services.opensnitch-ui.enable = true;
}
