{ inputs, lib, pkgs, config, outputs, ... }: {
  imports = [
    ./modules
    ../features/editors/neovim
    ../features/cli
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
  };

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home = {
    username = lib.mkDefault "anthony";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = "22.11";
    sessionPath = [ "$HOME/.local/bin" ];
  };
}
