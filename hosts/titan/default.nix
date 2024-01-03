{ pkgs, inputs, outputs, unstable, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager

    ./hardware-configuration.nix

    ../common/global
    ../common/users/anthony

    ../common/optional/pipewire.nix
    ../common/optional/docker.nix
    ../common/optional/quiet-boot.nix
    ../common/optional/greetd.nix
    ../common/optional/flatpak.nix
    ../common/optional/gamemode.nix
    ../common/optional/wayland.nix
  ];

  networking = {
    hostName = "titan";
    useDHCP = false;
    interfaces.enp7s0 = {
      useDHCP = true;
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services = { };

  # Enable polkit for Sway/Wayland
  security.polkit.enable = true;

  home-manager = {
    extraSpecialArgs = { inherit inputs unstable; };
    users = {
      anthony = import ../../home/anthony/titan.nix;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

