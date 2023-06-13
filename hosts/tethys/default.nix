{ pkgs, inputs, outputs, unstable, ... }: {
  imports = [
    inputs.hardware.nixosModules.lenovo-thinkpad-x1-9th-gen
    inputs.home-manager.nixosModules.home-manager

    ./hardware-configuration.nix

    ../common/global
    ../common/users/anthony

    ../common/optional/wireless.nix
    ../common/optional/pipewire.nix
    ../common/optional/kmonad
    ../common/optional/docker.nix
    ../common/optional/quiet-boot.nix
    ../common/optional/greetd.nix
  ];

  networking = {
    hostName = "tethys";
    useDHCP = false;
    interfaces.wlp0s20f3 = {
      useDHCP = true;
    };
  };
  
  programs.hyprland = {
    enable = true;
    xwayland.enable = false;
  };

  services = {
    kmonad = {
      enable = true;
      keyboards = {
        options = {
	  name = "laptop";
          device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
	  defcfg = {
            enable = true;
	    fallthrough = true;
	    allowCommands = false;
	  };
	  config = builtins.readFile ../common/optional/kmonad/colemak-dh-extend-ansi.kbd;
	};
      };
    };
  };

  # Enable polkit for Sway/Wayland
  security.polkit.enable = true;

  home-manager = {
    extraSpecialArgs = { inherit inputs unstable; };
    users = {
      anthony = import ../../home/anthony/tethys.nix;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
