{ inputs, lib, ... }: {
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];

      # Enable Cachix for Hyprland
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    # Enable automatic garbage collection
    gc = {
      automatic = true;
      randomizedDelaySec = "14m";
      options = "--delete-older-than 3d";
    };
  };
}
