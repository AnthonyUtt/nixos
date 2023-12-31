{ inputs, lib, pkgs, config, outputs, ... }: 
let
  overlays = {
    personal = import ../../../pkgs/overlay.nix;
  };
in
{
  imports = [
    ./modules
    ../features/editors/neovim
    ../features/cli
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      permittedInsecurePackages = [
        "electron-25.9.0"
      ];
    };
    overlays = builtins.attrValues overlays;
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
    stateVersion = "23.05";
    sessionPath = [ "$HOME/.local/bin" ];
  };
}
